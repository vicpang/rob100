clc
im1=iread('walls-l.jpg',  'double', 'reduce', 2);
im2=iread('walls-r.jpg',  'double', 'reduce', 2);
sf1 = isurf(im1);
sf2 = isurf(im2);
m = sf1.match(sf2, 'top', 1000)
%estimate fundamental matrix as well as inliners 
randinit
[F,r] = m.ransac(@fmatrix,1e-4, 'verbose');
%display epipole lines of inliners of image2
cam = CentralCamera('image', im1);
cam.plot_epiline(F', m.inlier.subset(40).p2, 'y');

%get focal length
[~,md] = iread('walls-l.jpg');
f = md.DigitalCamera.FocalLength

%create a camera with the given focal length
cam = CentralCamera('image', im1, 'focal', f/1000, ...
    'pixel', 2*1.5e-6)
%get essentail matrixs
E = cam.E(F)
% decompose it to get camera motion
T = cam.invE(E, [0,0,10]')
%scale the translation by extra information: change in 0.3m in axis 
t = T.t;
T.t = 0.3 * t/t(1)
% draw 100 inliners
m2 = m.inlier.subset(100);
%compute rays of two cameras in the real world
r1 = cam.ray( m2.p1 );
r2 = cam.move(T).ray( m2.p2 );

% get ray intersection
[P,e] = r1.intersect(r2);
%depth coordinate
z = P(3,:);
%visulizae depth information
idisp(im1)
plot_point(m2.p1, 'y+', 'textcolor', 'y', 'printf', {'%.1f', z});