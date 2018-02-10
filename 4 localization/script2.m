close all
clear
clc

%specify command noise
V = diag([0.02, 0.5*pi/180].^2);
%simluate a vehicle
veh = Bicycle('covar', V)
veh.add_driver( RandomPath(10) )

% Fx describes how command changes state
veh.Fx([0,0,0],[0.5,0.1])
%define variance of initial pose to be very small
P0=diag([0.005,0.005,0.001].^2);
%run ekf
ekf=EKF(veh,V,P0);
randinit
ekf.run(1000);


clf
%true path
veh.plot_xy();
hold on
%filter's estimation path (red)
ekf.plot_xy('r');

%varaince at step700
P700=ekf.history(700).P
%plot uncertainty ellipse
ekf.plot_ellipse('g')
