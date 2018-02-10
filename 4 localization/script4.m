randinit
map = LandmarkMap(20);
veh = Bicycle(); % error free vehicle
veh.add_driver( RandomPath(map.dim) );
W = diag([0.1, 1*pi/180].^2);
sensor = RangeBearingSensor(veh, map, 'covar', W, 'animate');
ekf = EKF(veh, [], [], sensor, W, []);

ekf.run(1000);

figure(1)
map.plot();
ekf.plot_map('g');
veh.plot_xy('b');

figure(2)
heatmap(ekf.history(1000).P)
