% This file sets all the parameters.
% DO NOT ADD NEW VARIABLES HERE.
% AS WE WILL REPLACE THIS FILE WITH OUR OWN PARAMETERS TO TEST YOUR CODE!

%% Clear The Environment.
clc;
clearvars;
close all;

%% Simulation Parameters
% amount of time we will simulate for - subject to change
tend = 100;

%% Plant parameters
g = 9.8;
Vmax = 1000;

%% Scenario Parameters (Things you can/should change to test your code!)

q_0 = 0; % initial position of car
qdot_0 = 0; % initial velocity of car.

% disturbance due to road's incline - numerical value will change
theta = deg2rad(10);
dbar = 0*g*sin(theta); % depends on plant parameters - see project description

% desired velocity when no one in front
qdot_ref = 100;

% desired inter-vehicle distance
r = 10;

% Leader Vehicle Parameters
% velocity of car ahead (leader) = vL  + a*cos(omega * t).
vL = 80;
a = 0;
omega = 10;

% initial position of car ahead (leader)
ql_0 = 100;

%% Leader Vehicle Parameters for Cutoff Manoeuvre
% Time for cutoff.
t_cutoff = 30;

% Distance at which Leader cuts off follower by.
initial_cutoff_distance = 5;

% What a initial "far away" distance is .
distance_far_away = 3000;

% Whether to enable the cutoff mode!
is_cutoff_manoeuvre = false;
