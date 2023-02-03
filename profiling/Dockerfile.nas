FROM prasant/ubuntu

WORKDIR /root
# get the NAS parallel benchmark workloads
RUN wget https://www.nas.nasa.gov/assets/npb/NPB3.4.2.tar.gz
RUN tar xvzf NPB3.4.2.tar.gz
## MPI tests
WORKDIR /root/NPB3.4.2/NPB3.4-MPI
RUN cp config/make.def.template config/make.def
RUN make bt cg ep ft is lu mg sp CLASS=A NPROCS=`nprocs` SUBTYPE=full
## OMP tests
WORKDIR /root/NPB3.4.2/NPB3.4-OMP
RUN cp config/make.def.template config/make.def
RUN make bt cg ep ft is lu mg sp CLASS=A NPROCS=`nprocs` SUBTYPE=full
WORKDIR /root
RUN rm *.tar.gz
