# RosDepends
Just a Test Library for the ROS 2 Dependencies on MacOS Ventura

## Source Install

Here ~/ros2_rolling is the location of my ROS 2 source install, so swap that out with whatever you're using, starting within that location.

Before building run the following command:
  - `brew uninstall orocos-kdl`
  
Additional Package Commands for Debuggig:
  - --package-up-to
  - --packages-ignore

`cd .. && rm -rf ros2_rolling && mkdir -p ~/ros2_rolling/src && cd ~/ros2_rolling && vcs import --input https://raw.githubusercontent.com/CursedRock17/RosDepends/main/ros2.repos src && cd ~/ros2_rolling/ && colcon build --symlink-install --packages-skip-by-dep python_qt_binding --package-up-to rviz_ogre_vendor --event-handlers console_direct+`

At this point we need to fix patch files I found these with a fuzzy finder and grep
- Rename the FeatureSummary file to OgreFeatureSummary
- Rename the `find_package(FeatureSummary)` to `find_package(OgreFeatureSummary)`

Now we should be able to finish the install so run the normal build statement:
`cd ~/ros2_rolling/ && colcon build --symlink-install --packages-skip-by-dep python_qt_binding --event-handlers console_direct+`

Then run:
  - `. ~/ros2_rolling/install/setup.zsh`

When building Additional Ros tools:
 - `brew install llvm@{wanted version}`
 - `sudo ln -s "$(brew --prefix llvm@{wanted version})/bin/clang-format" "/usr/local/bin/clang-format-{wanted version}"`

Continious Integration (CI)
 - Setup Github actions with Act
 or
 - Use Colcon to build the industrial_ci pipeline
 - Build with ros2 run
 
 ## CI with Colcon
 
 -- Prerequistes:
     - `brew install coreutils`
     - `brew install bash`
 
 - Create a [Workspace](https://docs.ros.org/en/humble/Tutorials/Beginner-Client-Libraries/Colcon-Tutorial.html) as per Colcon's guide. It can be cleared so that we just have the src file system. but instead of an example library clone in [industrial_ci](https://github.com/ros-industrial/industrial_ci) on the master branch.
 - Next insert your wanted testing repository into `src` so you can do `git clone https://gitrepo.git -b main` or you can do a copy (More Likely) of a local repository for constant testing with `cp -R old_location workspace/src`
 - In order to use industrial_ci we have to make some changes for OSX specifically `scripts/run_ci` needs to use `greadlink` instead of `readlink`
 - Now we can install our testing software : `colcon build --packages-select industrial_ci`
 - Then we need to actually setup the CI specific to a package for this example I'm using moveit2 seen from their docs: https://moveit.ros.org/documentation/contributing/continuous_integration/
 
 - I run a small script of : `ros2 run industrial_ci run_ci ~/workspace_location/src/package_to_test` with my locations and packages subbed in, to which we should run into some errors during the docker pull:
 `line 199: 1679972928N: value too great for base (error token is "1679972928N")`
 `/moveit2_ws/install/industrial_ci/share/industrial_ci/src/run.sh: No such file or directory` Solve this by removin all instances of `%N`, whcih should 2, in the run_sh script.
 
- We now need to use an image that fits to arm64 instead of the linux/amd64 listed on dockerhub
 
## Launching Moveit 2 
  We need to clone the following packages from source into our repo:
  [angles](https://github.com/ros/angles), [eigen_stl_containers](https://github.com/ros/eigen_stl_containers), [fcl](https://github.com/flexible-collision-library/fcl), [geometric_shapes](https://github.com/ros-planning/geometric_shapes), [launch_param_builder](https://github.com/PickNikRobotics/launch_param_builder), [object_recognition_msgs](https://github.com/wg-perception/object_recognition_msgs), [octomap](https://github.com/OctoMap/octomap), [octomap_msgs](https://github.com/OctoMap/octomap_msgs), [random_numbers](https://github.com/roshttps://github.com/OctoMap/octomap_msgsplanning/random_numbers), [rosparam_shortcuts](https://github.com/PickNikRobotics/rosparam_shortcuts), [ruckig](https://github.com/pantor/ruckig), [srdfdom](https://github.com/ros-planning/srdfdom)
  
  - We need to remove all `std::tr1::unordered_map` and `std::tr1::unordered_set` definitions from the code by simply removing tr1 and moving as usual
  - May need to add C++14 to files that cannot run boost due to version problems so :
  ```
  if (NOT CMAKE_CXX_STANDARD)
    set(CMAKE_CXX_STANDARD 14)
    set(CMAKE_CXX_STANRDARD_REQUIRED TRUE)
  endif()
  ```
  - Need to include glog via `glog::glog`
  - Need to remove some boost definitions like `signals` which is no longer a package
  - Ros Install with sudo  ./src/catkin/bin/catkin_make_isolated --install -DCMAKE_BUILD_TYPE=Release -DPYTHON_EXECUTABLE=/opt/homebrew/bin/python3.11
