FROM sfalexrog/raspbian:buster

# install packages
RUN apt-get update && apt-get install -q -y \
    dirmngr \
    gnupg2 \
    && rm -rf /var/lib/apt/lists/*

# setup keys
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654 \
    && curl http://deb.coex.tech/aptly_repo_signing.key 2> /dev/null | apt-key add -

# setup sources.list
RUN echo "deb http://packages.ros.org/ros/ubuntu buster main" > /etc/apt/sources.list.d/ros1-latest.list \
    && echo "deb http://deb.coex.tech/rpi-ros-melodic buster main" > /etc/apt/sources.list.d/rpi-ros-kinetic.list

COPY ./assets/melodic-rosdep-clever.yaml /etc/ros/rosdep/

# install bootstrap tools
RUN apt-get update && apt-get install --no-install-recommends -y \
    python-rosdep \
    python-rosinstall \
    python-vcstools \
    && rm -rf /var/lib/apt/lists/*

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

RUN rosdep init \
    && echo "yaml file:///etc/ros/rosdep/melodic-rosdep-clever.yaml" >> /etc/ros/rosdep/sources.list.d/20-default.list \
    && rosdep update

ENV ROS_DISTRO melodic
RUN apt-get update && apt-get install -y \
    ros-melodic-ros-core \
    && rm -rf /var/lib/apt/lists/*

COPY ./assets/ros_entrypoint.sh /

ENTRYPOINT [ "/ros_entrypoint.sh" ]
CMD [ "/bin/bash" ]
