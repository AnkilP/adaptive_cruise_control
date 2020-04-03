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
q = logsout.getElement('q').Values;
qdot = logsout.getElement('qdot').Values;
ql = logsout.getElement('ql').Values;
% c_v = logsout.getElement('Cum_velocity').Values;
% er = logsout.getElement('Effective_rdiff').Values;
% rv = logsout.getElement('Relative_Velocity').Values;
% sf = logsout.getElement('scaling_factor').Values;
%% Section 1

%the step response of the plant gives us an equation:
%g(t) = b*(1 - exp(-at))
%g(0) = b*a
%g ~=~ b * (1 - exp(-at)) at some t
b = max(qdot.data);
time_constant_value = b*(1 - exp(-1));
%------------------
[~, x] = min(abs(qdot.data - time_constant_value));
tau = qdot.time(x);
a = 1/tau;

[kp, ti, td, tau_d] = extra_calc(a, b, 0.1, 5, 5, 13, 17);
% display(kp);
% display(ti);
% display(td);
% display(tau_d);
display("done Section 1");

%% Plot simulation results
figure(1);
plot(y.Time, y.Data, 'LineWidth', 2);
title('Inter-vehicle distance versus time');
xlabel('time (s)', 'Interpreter','latex', 'FontSize', 17);
ylabel('$y(t) = q_\ell(t) - q(t)$', 'Interpreter','latex', 'FontSize', 17);
grid on;

figure(2);
plot(e.Time, e.Data, 'LineWidth', 2);
title('Tracking Error Signal');
xlabel('time (s)', 'Interpreter','latex', 'FontSize', 17);
ylabel('$r(t) - y(t)$','Interpreter','latex', 'FontSize', 17);
grid on;

% figure(3);
% plot(qdot.Time, qdot.Data, 'LineWidth', 2);
% title('Velocity of vehicle');
% xlabel('time (s)', 'Interpreter','latex', 'FontSize', 17);
% ylabel('$q(t)$','Interpreter','latex', 'FontSize', 17);
% % xline(tau);
% grid on;
% 
% figure(4);
% plot(u.Time, u.Data, 'LineWidth', 2);
% title('Control signal');
% xlabel('time (s)', 'Interpreter','latex', 'FontSize', 17);
% ylabel('voltage $u(t)$', 'Interpreter','latex', 'FontSize', 17);
% grid on;

% Print out Costs
fprintf('J1 Cost: %12.8f\r\n', J1);
fprintf('J2 Cost: %12.8f\r\n', J2);
fprintf('J1+J2 Cost: %12.8f\r\n', J1+J2);

% fprintf('b: %12.8f\r\n', b);
% fprintf('tau: %12.8f\r\n', tau);
% fprintf('b/tau: %12.8f\r\n', b/tau);
% fprintf('a: %12.8f\r\n', a);

% figure(7);
% plot(er.Time, er.Data, 'LineWidth', 2);
% title('Effective Diff');
% xlabel('time (s)', 'Interpreter','latex', 'FontSize', 17);
% ylabel('$q_\ell(t)$', 'Interpreter','latex', 'FontSize', 17);
% grid on;
% 
% figure(8);
% plot(rv.Time, rv.Data, 'LineWidth', 2);
% title('Relative Velocities');
% xlabel('time (s)', 'Interpreter','latex', 'FontSize', 17);
% ylabel('$q_\ell(t)$', 'Interpreter','latex', 'FontSize', 17);
% grid on;
% 
% figure(9);
% plot(sf.Time, sf.Data, 'LineWidth', 2);
% title('Scaling Factor');
% xlabel('time (s)', 'Interpreter','latex', 'FontSize', 17);
% ylabel('$q_\ell(t)$', 'Interpreter','latex', 'FontSize', 17);
% grid on;
% 
% 
