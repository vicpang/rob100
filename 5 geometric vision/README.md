## camera model
    1. projection of real world point into the camera coordinate is modeled by mulitplying matrix C
    2. C contains a matrix K which models intrinsic parameters of a camera
    3. scritp 1 shows an example of a camera model. we projec a meshgird into the camera, then translate and rotate the camera, we see the points changes in the formed image. Thus camera pose also matters

## camera calibration
    1. the process of determining intrinsic and extrinsic paramter of the camera
    2. we consider linear model here, that is , no lens distortion is considered, typically non-linear model is optimization over all parameters who are initialized using linear model
    3. given camera calibration matrix, most camer parameters can be recovered
    4. there are solid algorithms for camera calibration

## pose estimation
    1. the pose estimation problem is to determine the pose of a target coordinate frame w.r.t camera. We know a number of points in that coordinate, we know camera intrinsics, also their position in the image world is known.

## feature correspondence
    1. the problem of feature correspondence is that, we have two images of the same scene, but slightly different, then we find points in two images that corresponds to the same scene.
    2. scrtip2 shows an exmample of this. we first compute feature descriptors, like SURF feature. Then we run matching algorithm 
    3. we can visualize the distance of the descriptors, we can further finetune matching criteria, like only choose the top matches, etc. 
    4. by runing the script we see that by using top matchers, the lines are almost parallel

## multiple view geometry
    1. given two known cameras, corresponding point for a point in one image must lie in a line in the other image
    2. script 2 illustrates this idea. we have one point and two cameras, we see the points in two images are different. then we project center of each camera to the other, this results in epipoles, and then we can see a line connecting the two points


## fundamental matrix adn essential matrix
    1. the fundamental matrix is a function of camera paramters and relative camera pose between views, it can be used to express coplanarity/epipolar geometric relation easily. the fundamental matrix and a point in one image defines an epipolar line in the other image, which its conjugate points must lie
    2. essentail matrix is similar to fundamental matrix, it can also be used to express the geometric constraints, it is used in a normalized coordinates, but it cannot fully recover parameters(up to a scale)
    
## estimating fundamental matrix 
    1. in real world, we don't have camera pose or calibrated camera, so we need to estimate the fundamental matrix from image adata: N pairs of corresponding points
    2. in script4 , we first illustrate estimating F from corresponding points, and shows the importance of correct correspondence, then we start from the matching example, use ransac to find good correspondence, as well as F matrix

## planar homography
    1. given a set of points in two images, we can estimate a homography when these points are on a plane and correspondence is known.
    2. in script5 we first see an example of such homography transform, then we come two two images, computing matched points first, then use ransac to estimate points that best fits a plane in the world, then we display the inliners and outliers

## sparse stereo
    1. stereo vision is the technique of estimating 3dim structure of the world from two images taken from different viewpoint, sparse stereo only recovers the corresponding point pair
    2. script 6 shows an example of steroe. It uses ransac to estimate inliners and outliers first, then choose 100 inliners, compute rays for each camera, and compute intersection. Third entry is the depth information
    3. assumptions: camera focal length is known, and translation between two camera is known

## dense stereo matching
    1. a stereo pair is usually taken simultaneously by a camera pair. disparity can be defined by displacement along the horizontal epipolar line
    2. for a given point, to find corresponding pixel, we use slide a patch along the epipole line until find a good match. For similarity, there are various ways, like NCC similarity, we plot similarity-disparity curve and find peaks
    3. we define disparity at each pixel as the integer value where the greatest similarity was found
    4. in scrtip 7, we first compute stereo with peak refinement, then label each pixel with failure mode and visualize, then we reconstruct 3d coordinates from the images and display

## rectification
    1. stereo cameras are built so that optical axes of cameras are parallel, however, there are limits to the precision of mechanical alignment, so image rectification is used to correct these errors through warping images
    2. in scrtip8, we load in two images, compute surf, match, ransoc F, then compute rectification. Rectification takes F and m as inputs. after rectification,we see corresponding points will have the same vertical coordinates. We can then further use the rectified pairs for dense stereo

## bundle adjustment
    1. we estimated 3d coordinates of landmark points by triangulation, to assess the quality, we backproject the point and evaluate the error in image-plance distance the back-projected landmark and its observed position. This error can come from estimated camera pose, or landmark coordinates, or both. 
    2. bundle adjustment is an optiization process that simultaneously adjusts the camera poses and the landmark coordinates so as to minimize the total backprojection error. generally speaking, when motion is known, we aim to recover 3d information , this is called structure from motion, when motion is our goal and we do not care about image structure, we are doing visual odometry