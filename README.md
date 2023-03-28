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
 `/moveit2_ws/install/industrial_ci/share/industrial_ci/src/run.sh: No such file or directory`
 
 
