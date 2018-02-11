clc
randinit;  % ensure repeatable results

T1 = SE3(-0.1, 0, 0) * SE3.Ry(0.4);
cam1 = CentralCamera('name', 'camera 1', 'default', ...
    'focal', 0.002, 'pose', T1)

T2 = SE3(0.1, 0,0) * SE3.Ry(-0.4);
cam2 = CentralCamera('name', 'camera 2', 'default', ...
    'focal', 0.002, 'pose', T2);

%point in world
P = SE3(-1, -1, 2) * (2*rand(3,20) );
%point in image
p1 = cam1.project(P);
p2 = cam2.project(P);

%estimate fundamental matrix
F = fmatrix(p1, p2)

%epipoline
cam2.plot(P);
cam2.plot_epiline(F, p1, 'r')

%wrong correspondence result in poor performance
p2(:,[8 7]) = p2(:,[7 8]);
fmatrix(p1, p2)
epidist(F, p1(:,1), p2(:,1))
epidist(F, p1(:,7), p2(:,7))

%RANSAC solver
im1 = iread('eiffel2-1.jpg', 'mono', 'double');
im2 = iread('eiffel2-2.jpg', 'mono', 'double');
sf1 = isurf(im1)
sf2 = isurf(im2)
m = sf1.match(sf2)
randinit
F =  m.ransac(@fmatrix, 1e-4, 'verbose')

%visualize inliner and outliner

idisp({im1, im2});
m.inlier.subset(100).plot('g')
figure()
idisp({im1, im2});
m.outlier.subset(100).plot('r')