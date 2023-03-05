# RosDepends
Just a Test Library for the ROS 2 Dependencies on MacOS Ventura
  
  Build with: cd .. && rm -rf ros2_rolling && mkdir -p ~/ros2_rolling/src && cd ~/ros2_rolling && vcs import --input https://raw.githubusercontent.com/CursedRock17/RosDepends/main/ros2.repos src &&  cd ~/ros2_rolling/ && colcon build --symlink-install --packages-skip-by-dep python_qt_binding --packages-ignore rviz_ogre_vendor rviz --event-handlers console_direct+

or

cd .. && rm -rf ros2_rolling && mkdir -p ~/ros2_rolling/src && cd ~/ros2_rolling && vcs import --input https://raw.githubusercontent.com/CursedRock17/RosDepends/main/ros2.repos src && cd ~/ros2_rolling/ && colcon build --symlink-install --packages-skip-by-dep python_qt_binding --packages-up-to kdl_parser --packages-ignore rviz_ogre_vendor rviz --event-handlers console_direct+

in order to run rviz we need to enable its library linking

Before building run the following commands:
  - `brew uninstall orocos-kdl`

Then run:
  - `. ~/ros2_rolling/install/setup.zsh`

When building Additional Ros tools:
 - `brew install llvm@{wanted version}`
 - `sudo ln -s "$(brew --prefix llvm@{wanted version})/bin/clang-format" "/usr/local/bin/clang-format-{wanted version}"`
