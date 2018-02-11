L = iread('walls-l.jpg', 'mono', 'double', 'reduce', 2);
R = iread('walls-r.jpg', 'mono', 'double', 'reduce', 2);
sL = isurf(L);
sR = isurf(R);
m = sL.match(sR, 'top', 1000);
%compute fundamental matrix
F = m.ransac(@fmatrix,1e-4, 'verbose');
%rectification needs matching points and fundamental matrix
[Lr,Rr] = irectify(F, m, L, R);
stdisp(Lr, Rr)
%further for stero
 d = istereo(Lr, Rr, [180 530], 7, 'interp');
 figure()
 idisp(d)