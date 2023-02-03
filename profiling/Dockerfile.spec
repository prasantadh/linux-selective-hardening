FROM prasant/ubuntu

# get the spec cpu 2006 on the container
# mounting the iso requires privileged access
# which isn't allowed by docker file.
# Do this on the benchmarking script
COPY spec.tar.gz   /root/spec.tar.gz
WORKDIR /root
RUN tar xvzf spec.tar.gz
RUN rm spec.tar.gz
RUN cd spec && . ./shrc && \
    runspec \
    --action build \
    --config Example-linux64-amd64-gcc43+.cfg \
    --noreportable \
    bzip2 \
    gcc \
    mcf \
    gobmk \
    hmmer \
    sjeng \
    libquantum \
    h264ref \
    omnetpp \
    astar \
    xalancbmk

