FROM ubuntu:jammy

# set environment variables for tzdata
ARG TZ=America/New_York
ENV TZ=${TZ}

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update &&\
  yes | unminimize &&\
  apt-get -y install\
  # install GCC-related packages
  binutils-doc cpp-doc gcc-doc g++ g++-multilib gdb gdb-doc glibc-doc\
  libstdc++-10-doc make make-doc cmake\
  # install clang related packages
  clang lldb clang-format\
  # install interactive programs (emacs, vim, nano, man, sudo, etc.)
  bc curl dc git git-doc man micro vim nano\
  # set up libraries
  libreadline-dev locales wamerican libssl-dev\
  # install programs used for networking
  psmisc sudo wget dnsutils inetutils-ping iproute2 net-tools netcat\
  telnet time traceroute \
  # install dependencies for gem5
  build-essential m4 scons zlib1g zlib1g-dev libprotobuf-dev\ 
  protobuf-compiler libprotoc-dev libgoogle-perftools-dev python3-dev\
  python3-pip libboost-all-dev pkg-config \
  # install dependencies for ripes
  ninja-build '^libxcb.*-dev' libx11-xcb-dev libegl1-mesa-dev libglu1-mesa-dev libxrender-dev libxi-dev libxkbcommon-dev libxkbcommon-x11-dev

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

# clone qt6 repo
RUN git clone git://code.qt.io/qt/qt5.git /home/qt6 &&\
  cd /home/qt6 &&\
  git switch 6.5.1

# build qt6.5.1 from source
RUN perl init-repository --module-subset=qtbase,qtsvg,qtcharts &&\
  mkdir /home/qt6.5.1-build &&\
  cd /home/qt6.5.1-build &&\
  ../configure -prefix /home/qt6/install &&\
  cmake --build . --parallel 4 &&\
  cmake --install .

ENV CMAKE_PREFIX_PATH=/home/qt6/install

# clone Ripes repo
RUN git clone --recursive https://github.com/browncs1952y/Ripes-1952y /home/Ripes

# build ripes from source
RUN cd /home/Ripes &&\
  cmake . -DCMAKE_PREFIX_PATH=/home/qt6/install &&\
  make -j8

# git build arguments
ARG USER=cs1952y\ User
ARG EMAIL=nobody@example.com

# configure your environment
ARG USER=cs1952y\ User
ARG EMAIL=nobody@example.com

# configure your environment
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

USER cs1952y-user
RUN rm -f ~/.bash_logout

WORKDIR /home/cs1952y-user
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["/bin/bash", "-l"]
