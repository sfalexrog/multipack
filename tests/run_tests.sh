#!/bin/bash

docker run --rm -v $(pwd):/rosbuild/src/ -v $(pwd)/output:/output sfalexrog/multipack:melodic

