%% Project ECE380: Analog Control systems, Winter 2020

% Read this function to see what parameters are available!
set_simulation_parameters

%% Create any new variables you want and control computations here!

%% Simulate closed-loop system using simulink
sim('adaptive_cruise_control_student_version_2018a');

%% Pull out Timeseries data
y = logsout.getElement('distance_to_leader').Values;
e = logsout.getElement('tracking_error').Values;
u = logsout.getElement('control').Values;
qdot = logsout.getElement('qdot').Values;

%% Section 1

% the step response of the plant gives us an equation:
% g(t) = b*(1 - exp(-at))
% g(0) = b*a
% g ~=~ b * (1 - exp(-at)) at some t
b = max(qdot.data);
time_constant_value = b*(1 - exp(-1));
%------------------
[~, x] = min(abs(qdot.data - time_constant_value));
tau = qdot.time(x);
a = 1/tau;

%% Section 2

%

%% Plot simulation results
figure(1);
plot(y.Time, y.Data, 'LineWidth', 2);
title('Inter-vehicle distance versus time');
xlabel('time (s)', 'Interpreter','latex', 'FontSize', 17);
ylabel('$y(t) = q_\ell(t) - q(t)$', 'Interpreter','latex', 'FontSize', 17);
grid on;

figure(2);
plot(e.Time, e.Data, 'LineWidth', 2);
title('Tracking error');
xlabel('time (s)', 'Interpreter','latex', 'FontSize', 17);
ylabel('$r(t) - y(t)$','Interpreter','latex', 'FontSize', 17);
grid on;

figure(3);
plot(qdot.Time, qdot.Data, 'LineWidth', 2);
title('Velocity of vehicle');
xlabel('time (s)', 'Interpreter','latex', 'FontSize', 17);
ylabel('$\dot{q}(t)$','Interpreter','latex', 'FontSize', 17);
xline(tau);
grid on;

figure(4);
plot(u.Time, u.Data, 'LineWidth', 2);
title('Control signal');
xlabel('time (s)', 'Interpreter','latex', 'FontSize', 17);
ylabel('voltage $u(t)$', 'Interpreter','latex', 'FontSize', 17);
grid on;

%% Print out Costs
fprintf('J1 Cost: %12.8f\r\n', J1);
fprintf('J2 Cost: %12.8f\r\n', J2);
fprintf('J1+J2 Cost: %12.8f\r\n', J1+J2);

fprintf('b: %12.8f\r\n', b);
fprintf('tau: %12.8f\r\n', tau);
fprintf('b/tau: %12.8f\r\n', b/tau);
fprintf('a: %12.8f\r\n', a);

