## script 1
    1. problem description
        this is called Braitenberg vehicle. it is moving in 2d toward a local maxima of a scalar field. The sensor is given as a function of sensor position (x,y), it returns the sensor intensity
    2.  control
        Two sensors are used and speed is given by 
            `v=2-sR-sL`  
        Control is basd on sensor reading difference
    then script 1 gives the implementation of this system

## script2
    1. bugs: a kind of robot that seek path to a goal position in presence of nondriveable aeras and obstacle
    2. assumption
        - robots operates in grid world and occupies one grid cell
        - robot can move to eight neighboring grid cells
        - it can determine its position on the map
        - robot can only sense its goal and whehter adjacent cells are occupied
    3. a house plot is loaded for visualization, places are given. we use the house data to create a Bug2 algorithm.
    4. we can run queries from starting point to destination point and output the path
    5. the solution is suboptimal, and fundamental reason is that robot is limited by not using a map, where it can see the big picture.  The paths are locally optimal but not globally optimal
    This is why we need Map-Based Planning

## script3
    1. occupancy grid is used to represent map and robot position. Occupance grid treats world as a grid of cells and each cell is marked as occupied or unoccupied
    2. all planners are based on grid occupancy grid and derived from class Navigation of toolbox
    3. assumptions
        - robot operates in a grid world and can move to any neighboring grid cell
        - can determine its position on the plane
        - use the map to compute path it will take
    4. making a map
        `map=zeros(100,100);`
        `map(40:50,20:80)=1;`
        `map=makemap(100);` % a toolbox function
    5. distance transform matrix
        we initialize a matrix with destination as 1, and all others as zero. then distance transform matrix is another matrix, each grid contains distance to the destination using l2 distance
        `dx=DXform(house)` %create the transform matrix
    6. example of doing query
        `dx.plan(place.kitchen);`
        `p=dx.query(place.br3, 'animate');`
        `dx.plot(p)`
    7. this is impractical for large map

## script4
    1. another approach is to use graph search algorithm D*. 
        - generalize occupancy grid to a cost map 
        - cell contains motion cost, and obstacles corresponds to Inf 
    2. D* supports incremental replanning, when we find world is different from map, we can replan
    3. The model is already implemented, details refer to script 4, and in fact it is very slow in planning phase, but query phase is very fast

## script5
    1. disadvantage of an expensive planning phase is that, once cost is changed, or something changes and needs replanning, then it takes a long time
    2. the roadmap approach builds a network of obstacle free paths throught the environment, it only needs to be computed once and can get us from any start location to any goal location
    3. first part of scrtip 5 shows how to create such a roadmap using image processing
    4. for large maps, this method is also costy, we can sparsely sample the world map , this results in PRM
    5. script 5 show how to create PRM and do queries

## script6
    1. navigation should also take into account the vehicle motion constraints, like the wheeled vehicle have significant motion constraint. We need to design a path from the outset that we know the vehicle can follow
    2. we create a lattice of nodes, where each node represents the robot pose (x,y,theta), see script 6 on how to create such a lattice
    3. we make plan on lattice and query on lattice, see script 6

## script7
    1 RRT: probabilistic based methods that can also generate kinematically feasitble pathes

# summary
    1. everything we need is based on the assumption that we have the map, and know the robot location. but how do we get them in the first place?
    2. robotics system toolbox from mathworks provide binary occupancy grid and prm implementation