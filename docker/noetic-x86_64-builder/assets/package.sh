#!/bin/bash

set -e

echo "--- Setting up environment"
export DEB_BUILD_OPTIONS="parallel=$(nproc)"
echo "APT::Acquire::Retries \"3\";" > /etc/apt/apt.conf.d/80-retries

cd /rosbuild
echo "--- Installing dependencies"
apt-get update
rosdep install --from-paths src --ignore-src --rosdistro noetic -y

echo "--- Generatig rosdep file"
/multibloom.py rosdep > generated_packages.yaml
echo "--- Generated file contents:"
cat generated_packages.yaml

echo "--- Adding rosdep file to rosdep definitions"
cp generated_packages.yaml /etc/ros/rosdep
echo "yaml file:///etc/ros/rosdep/generated_packages.yaml" > /etc/ros/rosdep/sources.list.d/99-generated.list

echo "--- Updating rosdep"
rosdep update

#echo "--- Building and installing packages locally"
#catkin init
#catkin config --install --install-space /opt/ros/melodic
#catkin build

echo "--- Creating packages for distribution"
/multibloom.py generate

echo "--- Copying results to output directory"

find . -iname '*.deb' -exec cp {} /output \;
cp ./generated_packages.yaml /output
