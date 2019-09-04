#!/bin/bash

echo "--- Registering binfmt_misc support for arm"
docker run --rm --privileged sfalexrog/qemu-register:v4.1.0

#echo "--- Building for Kinetic"
#pushd kinetic
#docker build --rm --tag=sfalexrog/multipack:kinetic .
#popd

echo "--- Building for Melodic"
pushd melodic
docker build --rm --tag=sfalexrog/multipack:melodic .
popd