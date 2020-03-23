%% Section 2

% We want < 10% overshoot
% We want rising time of 5
% The resulting transfer function: s^2 + 0.65136s + 0.304704
% The desired characteristic polynomial is of degree 3
% so we'll add a factor of (s + 4) to the transfer function
% The resulting ch. p. is: (s^2 + 0.65136s + 0.304704)(s + 4)

s = tf(['s']);
desired_poly = 