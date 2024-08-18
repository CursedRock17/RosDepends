# RosDepends

A repository for the development of ROS 2 on MacOS

## Current Support

`RosDepends` currently supports the active installations of the following distributions of ROS 2 on MacOS Ventura:
  - Rolling

## Source Install

### 1.0 Base Requirements

On MacOS it's imperative to have both `XCode` and `homebrew` on one's system.
Once one has both of these, they can install anything else they may need

 - Install XCode:
  [XCode](https://apps.apple.com/app/xcode/id497799835)
 - Install XCode CLI Tools:
 ```
     xcode-select --install
    # This command will not succeed if you have not installed Xcode.app
    sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
    # If you installed Xcode.app manually, you need to either open it or run:
    sudo xcodebuild -license
    # To accept the Xcode.app license
 ```
 - Install homebrew:
 [Installation](https://brew.sh/)


### 1.1 Setup

`RosDepends` uses installs through source development, unfortunately binaries aren't available at this time.
`RosDepends` uses `shell` (`.zsh`) files to make the development process easier

Often times the distribution will be stored at `~/ros2_{distribution}`, so that all one must do is source the install by doing `source ~ros2_{distribution}/install/setup.zsh`
Additionally, `RosDepends` is currently using a virtual python environment to allow easy customization per library with `pipenv`, so as a distribution is created, there will be a `requirements.txt` within each install so all one must do is copy the python libraries and install in the development of whatever library:

```pipenv install -r path/to/requirements.txt && pipenv shell```

### 1.2 Utilization of Scripts

There are two ways to install distributions and repositories from `RosDepends`

1. Navigate through the Github website to a certain script, for example we'll use the ros2_rolling installation

Installation Link: https://github.com/CursedRock17/RosDepends/tree/main/scripts/ros2_rolling_install.zsh

From this link, simple copy and paste everything from the script into a new terminal window and hit enter

2. Cloning the Repository

One may also enter in the terminal:

```
git clone https://github.com/CursedRock17/RosDepends.git -b main
```

From this point `chmod +x ~/path_to_RosDepends/scripts/ros2_{distribution}_install.zsh`

Then simply run  `./path_to_RosDepends/scripts/ros2_{distribution}_install.zsh` and the script will do the rest of the work.

## Building Additional Ros Tools:
 - `brew install llvm@{wanted version}`
 - `sudo ln -s "$(brew --prefix llvm@{wanted version})/bin/clang-format" "/usr/local/bin/clang-format-{wanted version}"`


## Finding Issues

As seen in [this discourse link](https://discourse.ros.org/t/macos-support-in-ros-2-galactic-and-beyond/17891/38) MacOS is no longer a tier 1 platform maintained by the ROS 2 team. It has been delegated to the community due to heapfuls of problems, which has come together in many great ways to allow us to use this platform. With isolation of environment and scripts, I've been able to break up installations so they are more stable, but there will always be problems. If there's an issue in a ROS 2 repository that may be releveant to the development of ROS 2 on MacOS, creating an issue to links to that original issue is always welcome. This way we have  a place to track and solve issues more readily as a community.

## Launching Moveit 2 (Currently not available)
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
  - Apple Clang doesn't support all features such as, but not limited to :
      - Floating Point Values in std::from_chars : Must become integers
      -

  ### ROS bridge (Currently Not Finished):
  - Need to include glog via `glog::glog`
  - Need to remove some boost definitions like `signals` which is no longer a package
  - Ros Install with sudo  ./src/catkin/bin/catkin_make_isolated --install -DCMAKE_BUILD_TYPE=Release -DPYTHON_EXECUTABLE=/opt/homebrew/bin/python3.11
  - Replace condattr_setclock with condattr_setpthread
  - Remove the @ in gencpp/scripts/msg.h.template in the const char* value() return

