FROM ubuntu:22.04

# set environment variables for tzdata
ARG TZ=America/New_York
ENV TZ=${TZ}

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update &&\
  yes | unminimize &&\
  apt-get -y install\
  # install GCC-related packages
  binutils-doc cpp-doc gcc-doc g++ g++-multilib gdb gdb-doc glibc-doc\
  # install interactive programs (emacs, vim, nano, man, sudo, etc.)
  libstdc++-10-doc make make-doc bc curl dc git git-doc man micro vim nano\
  # set up libraries
  libreadline-dev locales wamerican libssl-dev\
  # install programs used for networking
  psmisc sudo wget dnsutils inetutils-ping iproute2 net-tools netcat\
  telnet time traceroute \
  # install dependencies for gem5
  build-essential m4 scons zlib1g zlib1g-dev libprotobuf-dev\ 
  protobuf-compiler libprotoc-dev libgoogle-perftools-dev python3-dev\
  libboost-all-dev pkg-config

# set up default locale
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8

# remove unneeded .deb files
RUN rm -r /var/lib/apt/lists/*

# set up passwordless sudo for user cs1952y-user
RUN useradd -m -s /bin/bash cs1952y-user && \
  echo "cs1952y-user ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers.d/cs1952y-init

# create binary reporting version of dockerfile
RUN (echo '#\!/bin/sh'; echo 'echo 1') > /usr/bin/cs1952y-docker-version; chmod ugo+rx,u+w,go-w /usr/bin/cs1952y-docker-version

# clone gem5 repo
RUN git clone https://github.com/gem5/gem5 /home/gem5 &&\
  chmod ugo+rx,u+w,go-w /home/gem5 &&\
  chown -R cs1952y-user:cs1952y-user /home/gem5

# git build arguments
ARG USER=cs1952y\ User
ARG EMAIL=nobody@example.com

# configure your environment
USER cs1952y-user
RUN rm -f ~/.bash_logout

WORKDIR /home/cs1952y-user
CMD ["/bin/bash", "-l"]
