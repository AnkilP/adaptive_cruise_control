function [K_p, T_i, T_d, tau_d] = extra_calc(a,b)
%% Section 2

% We want < 10% overshoot
% We want rising time of 5
% The resulting transfer function: s^2 + 0.65136s + 0.304704
% The desired characteristic polynomial is of degree 3
% so we'll add a factor of (s + 4) to the transfer function
% The resulting ch. p. is: (s^2 + 0.65136s + 0.304704)(s + 4)

s = tf(['s']);
desired_poly = (s^2 + 0.65*s + 0.30)*(s + 4);
display(desired_poly);
tau = 1/a;
alpha = 1;
xx = [0; (a/b)*(tau*4.65 - 1); tau*2.9; tau*1.2] + alpha*[1; -1/b; -1; 0];
display(xx);

K_p = (xx(3)*xx(1) - xx(4))/(xx(1)^2);
T_i = (xx(3)*xx(1) - xx(4))/(xx(1)*xx(4));
T_d = (xx(4) - xx(3)*xx(1) + xx(2)*xx(1)^2)/(xx(1)*(xx(4) - xx(3)*xx(1)));
tau_d = 1/xx(1);

display(K_p);
display(T_i);
display(T_d);
display(tau_d);

end

