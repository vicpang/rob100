## script1
    1. this script demostrate a lane change using the velocity model. bicycle is const speed and has a steering angle change, then we see how the trajectory changes. (x,y,theta)

## script2
    1. this script shows using controllers for the task of line following
    2. one controller minimizes the robot's normal distance from the lane 
        - distance 
    3. second controller adjusts the orientation
        - proportional controller
    4. then use the combined control law to perform line keeping. from initial pose x0, we simulate how the robot will move under the two controllers

## script3
    1. this script show how to design controllers to follow a trajectory. the trajectory is given by a time sequence
    2. we move robot toward a point using a PI controller
    3. for angle steering, use a proportional controller
    4. then we implement the system and simulate the trajectory, we also see how speed and trajectory changes along time