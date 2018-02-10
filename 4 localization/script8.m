clc
%pose graph contains scan information
pg = PoseGraph('killian.g2o', 'laser');

% get scan at 2580, and plot it
[r, theta] = pg.scan(2580);
[x,y] = pol2cart (theta, r);
plot (x, y, '.')
%get two consecutive scans
p2580 = pg.scanxy(2580);
p2581 = pg.scanxy(2581);

hold on
plot(p2581(1,:),p2581(2,:),'.')

%running algorithm for computing transformation
T = icp( p2581, p2580, 'verbose' , 'T0', transl2(0.5, 0), 'distthresh', 3)


