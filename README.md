# RosDepends
Just a Test Library for the ROS 2 Dependencies
-- May just use Ubuntu VM now
  
  Build with: cd .. && rm -rf ros2_rolling && mkdir -p ~/ros2_rolling/src && cd ~/ros2_rolling && vcs import --input https://raw.githubusercontent.com/CursedRock17/RosDepends/main/ros2.repos src &&  cd ~/ros2_rolling/ && colcon build --symlink-install --packages-skip-by-dep python_qt_binding --packages-ignore rviz_ogre_vendor rviz --event-handlers console_direct+
