FROM amazonlinux:2

RUN yum install -y gcc gcc-c++ make cmake3 git clang-devel llvm-devel tmux zlib-devel tmux zsh tar
RUN echo fs.inotify.max_user_watches=524288 | tee -a /etc/sysctl.conf

WORKDIR /tmp
RUN git clone --depth=1 --recursive https://github.com/MaskRay/ccls
WORKDIR /tmp/ccls
RUN cmake3 -H. -BRelease -DCMAKE_BUILD_TYPE=Release
RUN cmake3 --build Release
RUN cmake3 --build Release --target install
WORKDIR /
RUN rm -rf /tmp/ccls

ENTRYPOINT /usr/bin/zsh
