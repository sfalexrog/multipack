FROM sfalexrog/rpi-ros:melodic-core

# Build dependencies
RUN apt-get update && apt-get install -q -y \
    python-bloom \ 
    fakeroot \
    debhelper \
    dpkg-dev \
    && curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py \
    && python get-pip.py \
    && rm -rf get-pip.py \
    && rm -rf /var/lib/apt/lists/*

# Install additional tools
RUN pip install catkin-tools

# Add build scripts
COPY ./assets/package.sh /
COPY ./assets/multibloom.py /

CMD [ "/package.sh" ]
