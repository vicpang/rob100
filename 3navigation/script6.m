%lattice of how wheeled vehicle can move in two steps
lp = Lattice();
lp.plan('iterations', 2)
lp.plot()

%plan more iterations
lp.plan('iterations', 8)
%query from state to another
lp.query( [1 2 pi/2], [2 -2 0] );
%plot path 
lp.plot()