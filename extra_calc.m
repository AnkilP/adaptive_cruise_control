function [kp, ti, td, tau_d] = extra_calc(a,b, per_os, rising_time, alpha, kpp, kip)
%% Section 2

% We want < 10% overshoot
% We want rising time of 5
% The resulting transfer function: s^2 + 0.65136s + 0.304704
% The desired characteristic polynomial is of degree 3
% so we'll add a factor of (s + 4) to the transfer function
% The resulting ch. p. is: (s^2 + 0.65136s + 0.304704)(s + 4)

zeta = -log(per_os)/(sqrt(pi^2 + log(per_os)^2));
omega = (2.16*zeta + 0.6)/rising_time;
tau = 1/a;
s = tf(['s']);
desired_poly = (s^2 + 2*zeta*omega*s + omega^2)*(s + 40);
% display(desired_poly);
[num, ~] = tfdata(desired_poly, 'v');
controller = ((a/b)*(tau*num(2) - 1)*s^2 + tau*num(3)*s + tau*num(4) - alpha*s*((1/b) * s + 1))/(s^2 + alpha*s);

[num_cn, den_cn] = tfdata(controller, 'v');

% finding PID coefficients
kp = ((num_cn(2)*den_cn(2)) - num_cn(3))/den_cn(2)^2;
ti = ((num_cn(2)*den_cn(2)) - num_cn(3))/(num_cn(3)*den_cn(2));
td = (num_cn(3) - num_cn(2)*den_cn(2) + num_cn(1)*den_cn(2)^2)/(den_cn(2)*(num_cn(2)*den_cn(2) - num_cn(3)));
tau_d = 1/den_cn(2);

%finding the effective plant and controller combination for the outerloop
%PID
outerloop_effective_plant = controller * (b/(s + a));
display(outerloop_effective_plant);
num_opl = outerloop_effective_plant.Numerator{1};
den_opl = outerloop_effective_plant.Denominator{1};
% display(num_opl*s);
% display(den_opl);
chp_outerloop = num_opl * s + den_opl*(kpp*s + kip);
% display(chp_outerloop);

end

