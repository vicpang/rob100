Tgrid = SE3(0,0,1)*SE3.Rx(0.1)*SE3.Ry(0.2);
P = mkgrid(3, 1.0, 'pose', Tgrid);

cam1.clf(); cam2.clf();  %DIFF
p1 = cam1.plot(P, 'o');
p2 = cam2.plot(P, 'o');

H = homography(p1, p2)

p2b = homtrans(H, p1);

cam2.hold()
cam2.plot(p2b, '+')

p1b = homtrans(inv(H), p2);

im1=iread('walls-l.jpg',  'double', 'reduce', 2);
im2=iread('walls-r.jpg',  'double', 'reduce', 2);

sf1 = isurf(im1);
sf2 = isurf(im2);

m = sf1.match(sf2, 'top', 1000)
randinit
[H,r] = m.ransac(@homography, 4)
idisp(im1)
plot_point(m.inlier.p1, 'ys')