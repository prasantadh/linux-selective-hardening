all: build trim ubuntu deploy

nodeploy: build trim ubuntu

build: Dockerfile.build
	docker build -t "prasant/linux-5.15-gcov-build" --no-cache -f Dockerfile.build . | tee $@.log

trim: Dockerfile.kernel
	docker build -t "prasant/linux-5.15-gcov" --no-cache -f Dockerfile.kernel . | tee $@.log

ubuntu: Dockerfile.ubuntu
	docker build -t "prasant/ubuntu" --no-cache -f Dockerfile.ubuntu . | tee $@.log

phoronix: Dockerfile.phoronix
	docker build -t "prasant/phoronix" --no-cache -f Dockerfile.phoronix . | tee $@.log

spec: Dockerfile.spec
	docker build -t "prasant/spec" --no-cache -f Dockerfile.spec . | tee $@.log

nas: Dockerfile.nas
	docker build -t "prasant/nas" --no-cache -f Dockerfile.nas . | tee $@.log

deploy: linuxkit.yml
	linuxkit build -disable-content-trust linuxkit.yml && linuxkit run qemu -mem 49152 -cpus 8 linuxkit

clean:
	rm -rf linuxkit-* *.log *.tar.gz
