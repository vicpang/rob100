format compact
close all
clear
clc

%specify command noise
V = diag([0.02, 0.5*pi/180].^2);
%simluate a vehicle
veh = Bicycle('covar', V)
randinit
%simulate motion, going 1 meter , steering 0.3 rad
odo = veh.step(1, 0.3)
%robot true configuration (where it should be)
veh.x'
% return configuration taken noise into consideraion
veh.f([0 0 0], odo)
