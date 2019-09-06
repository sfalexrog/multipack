# multipack - An automated build and packaging tool for ROS packages [![Build Status](https://travis-ci.com/sfalexrog/multipack.svg?branch=master)](https://travis-ci.com/sfalexrog/multipack)

Ever wanted to package your ROS nodes as Debian packages, but couldn't figure out how to use the ROS buildfarm? Want to build packages for an unsupported architecture/rosdistro combination? Look no further!

`multipack` is a Docker-based tool to build and package your ROS packages for Debian. Releasing them is an excercise for the reader.

## Usage

Run the container while mounting the directory containing your package in `/rosbuild/src`:

```bash
docker run --rm -v /path/to/ros/packages:/rosbuild sfalexrog/multipack:melodic
```
