close all
clear
clc

%specify command noise
V = diag([0.02, 0.5*pi/180].^2);
%simluate a vehicle
veh = Bicycle('covar', V)


%simulate a map with landmarks
randinit
map = LandmarkMap(20, 10);
map.plot()
veh.add_driver( RandomPath(map.dim) )

%simulate a range bearing sensor with sensor noise
W = diag([0.1, 1*pi/180].^2);
sensor = RangeBearingSensor(veh, map, 'covar', W)

%randomly read a landmark
[z,i] = sensor.reading()
%compare with its absolut position
map.landmark(17)

%ekf with sensor
sensor = RangeBearingSensor(veh, map, 'covar', W, 'angle', ...
[-pi/2 pi/2], 'range', 4, 'animate');
P0=diag([0.005,0.005,0.001].^2);
ekf = EKF(veh, V, P0, sensor, W, map);
ekf.run(1000);

%visualize result
figure(1)
map.plot()
veh.plot_xy();
ekf.plot_xy('r');
ekf.plot_ellipse('k')

%variance plot
figure(2)
ekf.plot_P()
xlabel('Time step'); ylabel('(det P)^{0.5}'); grid

%error plot
figure(3)
ekf.plot_error('confidence', 0.95, 'nplots', 4)
plot_poly([1:1000; sensor.landmarklog], 'fill', 'b')
ylabel('land marks')
grid