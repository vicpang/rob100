clf
plotvol([-5 4 -1 4.5]);
T0 = eye(3,3);
trplot2(T0, 'frame', '0');
X = transl2(2, 3);
trplot2(X, 'frame', 'X');

R = trot2(2);

trplot2(R*X, 'framelabel', 'RX', 'color', 'r');
trplot2(X*R, 'framelabel', 'XR', 'color', 'r');

C = [1 2]';
plot_point(C, 'label', ' C', 'textcolor', 'k', 'solid', 'ko')


RC = transl2(C) * R * transl2(-C)
trplot2(RC*X, 'framelabel', 'XC', 'color', 'r');