FROM sfalexrog/rpi-ros:melodic-py3-core

# Build dependencies
RUN apt-get update && apt-get install -q -y \
    fakeroot \
    debhelper \
    dpkg-dev \
    && curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py \
    && python3 get-pip.py \
    && rm -rf get-pip.py \
    && rm -rf /var/lib/apt/lists/*

# We use a custom, patched bloom that supports Python3
RUN apt-get update && apt-get install -q -y \
    git \
    && git clone -b melodic-python3 https://github.com/sfalexrog/bloom /bloom \
    && pip install --upgrade /bloom \
    && rm -rf /bloom \
    && rm -rf /var/lib/apt/lists/*

# Install additional tools
RUN pip install catkin-tools

# Add build scripts
COPY ./assets/package.sh /
COPY ./assets/multibloom.py /

CMD [ "/package.sh" ]
