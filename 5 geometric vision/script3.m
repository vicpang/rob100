clc
%give two camera with two different poses
T1 = SE3(-0.1, 0, 0) * SE3.Ry(0.4);
cam1 = CentralCamera('name', 'camera 1', 'default', ...
    'focal', 0.002, 'pose', T1)
T2 = SE3(0.1, 0,0) * SE3.Ry(-0.4);
cam2 = CentralCamera('name', 'camera 2', 'default', ...
    'focal', 0.002, 'pose', T2);

axis([-0.5 0.5 -0.5 0.5 0 1])
cam1.plot_camera('color', 'b', 'label')
cam2.plot_camera('color', 'r', 'label')

P = [0.5 0.1 0.8]';

plot_sphere(P, 0.03, 'b');


p1 = cam1.plot(P)
p2 = cam2.plot(P)


cam1.hold
e1 = cam1.plot( cam2.centre, 'Marker', 'd', 'MarkerFaceColor', 'k')


cam2.hold
e2 = cam2.plot( cam1.centre, 'Marker', 'd', 'MarkerFaceColor', 'k')