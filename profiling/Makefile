all: build trim ubuntu deploy

nodeploy: build trim ubuntu

build: Dockerfile.build
	docker build -t "prasant/linux-5.15-gcov-build" --no-cache -f Dockerfile.build . | tee $@.log

trim: Dockerfile.kernel
	docker build -t "prasant/linux-5.15-gcov" --no-cache -f Dockerfile.kernel . | tee $@.log

ubuntu: Dockerfile.ubuntu
	docker build -t "prasant/ubuntu" --no-cache -f Dockerfile.ubuntu . | tee $@.log

deploy: linuxkit.yml
	linuxkit build -disable-content-trust linuxkit.yml 
	linuxkit run qemu -publish 6379:6379 -mem 32768 -cpus 8 linuxkit

clean:
	rm -rf linuxkit-* *.log *.tar.gz
