%compute free space
free = 1 - house;
%set margin
free(1,:) = 0; free(100,:) = 0;
free(:,1) = 0; free(:,100) = 0;
%compute network
skeleton = ithin(free);

%initialize
prm = PRM(house)
randinit
%create plan
prm.plan('npoints', 150)

p = prm.query(place.br3, place.kitchen);
prm.plot()
about p