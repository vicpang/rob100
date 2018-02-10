## vehicle odometry model
    1. vehicle pose is represented using a probability density, usually use gaussian
    2. vehicle state is represented by a vector(x,y,theta). A motion command is translation and rotation transform. It may also have some noise, which we use gausian with const variance to model. But this process is modeled by matrix multiplication 
    3. scrtip 1 shows such a simulation process, the vehicles executes a command, but it the odometry model has noise, so the supposed-to-be configuration is different from true configuration.


## pose estimation with kalman filter
    1. the problem of pose estimation is to estimate new pose given previous pose and noisy odometry. Kalman filter can be used to solve this problem(note it is different from slam)
    2. the algorithm output the optimal estimation of the unknown true pose and uncertainty associated with that pose
    3.  Fx models how state is changed purely by the odometry
    4. in scrtip 2, we show a simulation of the ekf. we define P0, initial pose variance to be small, also V as unkown odometry noise varaince, we run ekf for 1000 steps. It shows us the estimated configuration and the true configuration
    - Observation: the true configuration is computed using V, the red is estimated using ekf, it assumes we do not know the odometry noise. We see uncertainty increases overtime. 

## localization with a map
    1. we can simulate a map with landmarks, then we add sensor model to observe the landmarks. Sensor model is range bearing model, which outputs distance and orientation of the observed landmarks. Sensor also has noise
    2. at a given location, the robot can i)make an observation to the landmark (what really sees) ii) calculate an observation based on current position(this current position may not be correct, it is a prediction using odometry model), then ekf uses the true observation to make corrections, adjusting our belief about the current pose. Kalman gain is used to model this correction
    3. in script3 we see a simulation of such process,  we create range bearing sensor and initial variance, then pass to the ekf algorithm, we can see an animation where robots navigates using the localization and mapping information, however, map here is given
    4. Observation:
        - true and prediected state are very close
        - state variance does not grow monotonically, observing a landmark drops variance
        - observing landmarks can decrease error
    5 underlying assumption: we assume we know the identity of the landmark we observe, thus we can calculate the predicted observation, but in reality, data association is a problem

## creating a map
    1. in the above example, we simulated a map, but in reality , we need to create a map of our real world, it might be created by GPS, or the robot itself can create a map by driving through the environment.
    2. important assumption: landmark is identified perfectly, robot location is known perfectly
    3. state vector is an 2xM length vector of coordinates of landmarks, with a variance matrix
    4. a landmark position is estimated using robot pose and sensor observation. the state vector need to be extended whenever a new landmark is observed
    5. script 4 simulate such a process, the robot drives through the env, then create a map of locations, we see how accurate they are , from their true position. we also plot a heatmap of the covariance matrix


## localization and mapping
    1. known as slam, the problem is to do localization and mapping simutaneously. Here state vector is 3+2xM, and variance is a bigger matrix
    2. script 5 shows a simulation of such a process, we see estimation of location and landmark (with uncertainty ellispe) w.r.t the underlying truth. We plot the covariance matrix, which looks very dense
    3. drawback of ekf slam is that size of matrices involve as number of landmarks grow, which may be bad. Also we assume everything is gaussian, this model is not good for other sensors such as laser rangefinder, also it cannot deal with multi-mode in symmetric environment. We also need good estimate of covariance for noise, which is chanllenging

## Rao-Blackwellized SLAM
    1. observationL covariance of landmarks are sparse if we know our localization. Knowing robot poses makes the landmarks independent, it trajectory is not known, landmarks become correlated. this can be seen by the above ploted covariance matrices. So the kalman filter uses the correlation information so that a measurement of any one landmark provides information to improve the estimate of all the other landmarks and the robot pose  
    2. we assume a multi-hypothesis estimator, where every hypothesis represents a robot trajectory that we assume it is correct. That is , we draw a point cloud, and move them, every particle is a hypothesis, and based on that particle, we to a mapping, this mapping will be efficient since its variance matrix is sparse
    3. we then filter the particles, those hypothese that best explains the landmark measurements are retained, that is , the built map pretty well alignes with my observation.

## pose graph slam
    1. another approach to the slam problem is to build a pose graph(graph node can involve robot pose and landmark pose) and it is divided into frontend and backend, frontend is for building pose graph, backend is doing slam
    2. the simplest version is that, each node represent a robot pose, then constraints are imposed by measurements from odometry, laser scanner, cameras, etc.
    3. graph error: node i connects to node j, at i, robot can make a measurement about relative pose to j, which is usually different from the relative pose infered using node j. Thus we need to adjust node i, j to minimize the difference of relative pose between using measurements and using the nodes.  Overall, it is finding a node configuration that best matches our measurements. Global error is used as a weighted sum of error, and whole system is solved using least squares
    4. script 6 loads a pose graph and shows what it looks like when optimizing the graph

## particle filter for localization
    1. so far we have assumed odometry and landmark parameters are all guassian. Another approach is that we make no assumption but use Monte-Carlo sampling
    2. the process is very simple, we do state update to each particle, then make observation from each hypothesis, we use a particle importance to model how much the particle explains the observation. Then we select particle that best explains the observation using importance sampling. Larger weight particles are more likely to get chosen
    3. in scrtip 7 we simulate such a process, observations are as follows:
        - trajectory aligns pretty well
        - at starting point, particles are spread out, and immediately converges to the robot, since we did not specify any intial pose('kidnapped robot')
        - along time, error in pose drops drastically at first, then remain in a low level
        - we use samples of particles to reconstruct the distribution, which looks like gaussian

## laser odometry
    1. laser rangefinder is a sensor. it works good in night, but it can be affected by indra-red light from the sun at day time.
    2. scanning laser rangefinder can be used to estimate the change in robot pose, taking the place of wheel encoder
    3. in script 8 we get scanner data from pose graph, then we run ICP algorithm to estimate a transformation from two consecutive scan data
    4. we can further build a map if robot location is perfect known

# summary
    1. we see localization and mapping problem in robotics. First example, where we only use odometry information, localization is not accurate, then we introduce sensor, the rangebearing model and use observations for correction, this is ekf algorithm, we achieve good localization
    2. localization is based on a known map, so, how do we build a map in the first place? we apply the same state estimation algorithm for landmark position estimation, then build a map with sparse covariance matrix
    3. we combine the two problem together, estimating robot pose and landmark together using state estimation. we find the covaraince matrix is dense, then we briefly talked about the basic idea of sampling based slam algorithms, addressing some disadvantages of kalman filter based algorithms
    4. another approach, the graph based approach is introduced, and it models robot pose as node, the frontend creates constraints from sensor and odometry data, then error is defined as observation from constraints and actual observation, then the problem is to globally optimize the error, a weighted least sqaures problem
    5. particle filter is introduced, and we see how it solve the slam problem
    6. scan laser rangefinder model is introduced, and example of scan matching using ICP is simulated to give a sense of visual odometry.