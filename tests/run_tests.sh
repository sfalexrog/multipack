#!/bin/bash

docker run -it --rm -v $(pwd):/rosbuild/src/ sfalexrog/multipack:melodic /bin/bash

