im1 = iread('eiffel2-1.jpg', 'mono', 'double');
im2 = iread('eiffel2-2.jpg', 'mono', 'double');

%find conrers and display
figure(1)
hf = icorner(im1, 'nfeat', 200);
idisp(im1); hf.plot('gs');


%compute surf features and display
figure(2)
sf = isurf(im1, 'nfeat', 200);
idisp(im1); sf.plot_scale('g');

%matching
sf1 = isurf(im1)
sf2 = isurf(im2)
[m,corresp] = sf1.match(sf2)
figure()
idisp({im1, im2})
m.subset(100).plot('w')
corresp(:,1:5)

%match with distance distribution
figure()
m2 = sf1.match(sf2, 'all');
ihist(m2.distance, 'normcdf')

%match with threshold
mm = sf1.match(sf2, 'thresh', 0.05);
%match with top correspondence
mm = sf1.match(sf2, 'top', 20);
figure()
idisp({im1, im2})
mm.plot('w')
