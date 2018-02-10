randinit
map = LandmarkMap(20);
W = diag([0.1, 1*pi/180].^2);
V = diag([0.005, 0.5*pi/180].^2);
%vehicle with sensor noise , random drive through
veh = Bicycle('covar', V);
veh.add_driver( RandomPath(10) );

%sensor with noise, range bearing model
sensor = RangeBearingSensor(veh, map, 'covar', W);

%uncertainty in configuration
Q = diag([0.1, 0.1, 1*pi/180]).^2;
%covariance of likelihood function , likelihood fucntion used for
%importance sampling
L = diag([0.1 0.1]);

pf = ParticleFilter(veh, sensor, Q, L, 1000);
pf.run(1000);


figure()
map.plot();
veh.plot_xy('b');
hold on
pf.plot_xy('r');

figure()
plot(pf.std(1:100,:))
figure()
pf.plot_pdf()