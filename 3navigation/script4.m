load house;
% create D* navigation object
ds = Dstar(house);
%construct cost map from grid map
c = ds.costmap();
% create a plan to move to kitchen
ds.plan(place.kitchen);
ds.niter
%query
ds.query(place.br3);
%modify cost of a certain path
ds.modify_cost( [300,325; 115,125], 5 );
% plan again
ds.plan();
ds.niter
%query again
ds.query(place.br3);