FROM golang:1.5
MAINTAINER Ernest Micklei <ernest.micklei@gmail.com>

RUN apt-get update && apt-get install -y \
	git subversion make g++ python curl chrpath lbzip2 pkg-config && apt-get clean

# depot tools
RUN git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git /usr/local/depot_tools
ENV PATH $PATH:/usr/local/depot_tools

# v8worker
RUN git clone https://github.com/ry/v8worker.git /go/src/github.com/ry/v8worker
WORKDIR /go/src/github.com/ry/v8worker

# v8worker does not include the nohooks flag; let's change it
RUN sed -i 's/fetch v8/fetch --nohooks v8/g' Makefile

RUN make
RUN make install