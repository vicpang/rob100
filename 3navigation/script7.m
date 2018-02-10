car = Bicycle('steermax', 0.5);
rrt = RRT(car, 'npoints', 1000)
rrt.plan();
rrt.plot();
rrt = RRT(car, road, 'npoints', 1000, 'root', [50 22 0],'simtime', 4)
rrt.plan();

p = rrt.query([40 45 0], [50 22 0]);