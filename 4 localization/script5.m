randinit
P0 = diag([.01, .01, 0.005].^2);
map = LandmarkMap(20);
veh = Bicycle('covar', V);
veh.add_driver( RandomPath(map.dim) );
sensor = RangeBearingSensor(veh, map, 'covar', W, 'animate');
ekf = EKF(veh, V, P0, sensor, W, []);

ekf.run(1000);


figure(1)
map.plot();
ekf.plot_map('g');
ekf.plot_xy('r');
veh.plot_xy('b');

figure(2)
heatmap(ekf.history(1000).P)