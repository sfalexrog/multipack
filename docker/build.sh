#!/bin/bash

echo "--- Registering binfmt_misc support for arm"
docker run --rm --privileged sfalexrog/qemu-register:v4.1.0

echo "--- Building for Kinetic"
pushd kinetic-builder
docker build --rm --tag=sfalexrog/multipack:kinetic .
popd

echo "--- Building for Melodic"
pushd melodic-builder
docker build --rm --tag=sfalexrog/multipack:melodic .
popd

echo "--- Building for Melodic-python3"
pushd melodic-py3-builder
docker build --rm --tag=sfalexrog/multipack:melodic-py3 .
popd

echo "--- Building for Noetic"
pushd noetic-builder
docker build --rm --tag=sfalexrog/multipack:noetic .
popd

echo "--- Building for Noetic (x86_64)"
pushd noetic-x86_64-builder
docker build --rm --tag=sfalexrog/multipack:noetic-x86_64 .
popd

