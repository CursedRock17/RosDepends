brew install asio assimp bison bullet cmake console_bridge cppcheck \
  cunit eigen freetype graphviz opencv openssl orocos-kdl pcre poco \
  pyqt@5 python@3.11 qt@5 sip spdlog tinyxml2

echo "export OPENSSL_ROOT_DIR=$(brew --prefix openssl)" >> ~/.zshrc
export CMAKE_PREFIX_PATH=$CMAKE_PREFIX_PATH:$(brew --prefix qt@5)
export PATH=$PATH:$(brew --prefix qt@5)/bin

cd ~ && rm -rf ros2_rolling && mkdir -p ~/ros2_rolling/src && cd ~/ros2_rolling

python3.11 -m pip install --user --upgrade pipenv

  pipenv install argcomplete catkin_pkg colcon-common-extensions coverage \
  cryptography empy flake8 flake8-blind-except==0.1.1 flake8-builtins \
  flake8-class-newline flake8-comprehensions flake8-deprecated \
  flake8-docstrings flake8-import-order flake8-quotes \
  importlib-metadata jsonschema lark==1.1.1 lxml matplotlib mock mypy==0.931 netifaces \
  nose pep8 psutil pydocstyle pydot pyparsing==2.4.7 \
  pytest-mock rosdep rosdistro setuptools==59.6.0 vcstool

pipenv shell && pipenv lock -r > requirements.txt

vcs import --input https://raw.githubusercontent.com/CursedRock17/RosDepends/main/repos/ros2_rolling.repos src && cd ~/ros2_rolling/

colcon build --symlink-install --packages-skip-by-dep python_qt_binding --event-handlers console_direct+ --packages-ignore qt_gui_cpp rqt_gui_cpp

. ~/ros2_rolling/install/setup.zsh

echo "Setup complete and ros 2 has been sourced, happy building"
echo "Anytime you wish to use this setup, simply `source ~/ros2_rolling/install/setup`"
echo "You must also copy the virtual python environment: `pip install -r ~/ros2_rolling/requirements.txt`"
