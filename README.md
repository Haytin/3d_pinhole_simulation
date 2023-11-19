# 3D Matlab Pinhole Simulation
A MATLAB-based camera simulation tool for computer vision applications. This simulation allows users to model camera parameters, simulate images, and evaluate various computer vision algorithms



1. [Introduction](#introduction)
2. [Files](#files)
3. [Usage](#usage)
4. [License](#license)
5. [Usage](#usage)
# Introduction
This camera simulation tool is designed for computer vision enthusiasts and researchers to experiment with camera modeling and computer vision algorithms. The simulation covers a range of functionalities, from setting camera intrinsics and extrinsics to simulating images and applying various computer vision techniques.

# Files

- CamSimulation.fig: MATLAB figure file for the graphical user interface.
- CamSimulation.m: Main MATLAB script containing the core functionality of the camera simulation.
- angleplane.mat: MATLAB file containing information about the angle plane.
- commonpixel.m: MATLAB script for handling common pixel operations.
- costfun.m: MATLAB script defining the cost function for optimization.
- default_img.png: Default image used in the simulation.
- distort.m: MATLAB script for simulating distortion effects.
- dlt.m: MATLAB script implementing Direct Linear Transform (DLT) algorithm.
- dlt_costfun.m: MATLAB script defining the cost function for DLT.
- draw_wcs.m: MATLAB script for drawing the world coordinate system.
- get_images.m: MATLAB script for obtaining simulated images.
- get_object.m: MATLAB script for obtaining object information.
- hom_initial_costfun.m: MATLAB script defining the cost function for homography initialization.
- homography.m: MATLAB script for computing homography matrices.
- homography_costfun.m: MATLAB script defining the cost function for homography.
- ipyramid.mat: MATLAB file containing information about the image pyramid.
- landscape.mat: MATLAB file containing information about the landscape.
- optimize.m: MATLAB script for generic optimization.
- optimize_homography.m: MATLAB script for optimizing homography matrices.
- pyramid.mat: MATLAB file containing information about the pyramid.
- sensor_shape.m: MATLAB script defining the shape of the camera sensor.
- set_external.m: MATLAB script for setting external camera parameters.
- set_extrinsics.m: MATLAB script for setting extrinsic camera parameters.
- set_internal.m: MATLAB script for setting internal camera parameters.
- set_intrinsics.m: MATLAB script for setting intrinsic camera parameters.
- set_objectposition.m: MATLAB script for setting the position of the object.
- settings.m: MATLAB script containing simulation settings.
- show_camera.m: MATLAB script for visualizing the camera.
- show_homography.m: MATLAB script for visualizing homography results.
- show_results.m: MATLAB script for displaying simulation results.
- show_sensor.m: MATLAB script for visualizing the camera sensor.
- to_rotation.m: MATLAB script for converting rotation angles.

# Usage
For starting simulation use CamSimulation.m file.
