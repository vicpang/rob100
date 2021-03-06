L = iread('rocks2-l.png', 'reduce', 2);
R = iread('rocks2-r.png', 'reduce', 2);


%show disparity with refinement
[di,sim,peak] = istereo(L, R, [40 90], 3, 'interp');
idisp(di)
peak


status = ones(size(di));
%different failure mode
[U,V] = imeshgrid(L);
status(U<=90) = 2;
status(sim<0.8) = 3;
status(peak.A>=-0.1) = 4;
status(isnan(di)) = 5;
figure()
%show how they fail
idisp(status)


di(status>1) = NaN;

figure()
%true disparity
di = di + 274;
%compute x y z of each pixel in world
[U,V] = imeshgrid(L);
u0 = size(L,2)/2; v0 = size(L,1)/2;
b = 0.160;
X = b*(U-u0) ./ di; Y = b*(V-v0) ./ di; Z = 3740 * b ./ di;

surf(Z)
shading interp; view(-150, 75)
set(gca,'ZDir', 'reverse'); set(gca,'XDir', 'reverse')
colormap(flipud(hot))

