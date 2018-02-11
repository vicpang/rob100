cam = CentralCamera('focal', 0.015, 'pixel', 10e-6, ...
    'resolution', [1280 1024], 'centre', [640 512], 'name', 'mycamera')
%parameter matrix
cam.K
%camera matrix
cam.C



P = mkgrid(3, 0.2, 'pose', SE3(0, 0, 1.0));
P(:,1:4)

cam.project(P)
cam.plot(P)

%translation and rotate camera, project again
Tcam = SE3(-1,0,0.5)*SE3.Ry(0.9);
cam.plot(P, 'pose', Tcam)