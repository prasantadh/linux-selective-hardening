all: build_full trim_full build_selective trim_selective build_none trim_none ubuntu

full: build_full trim_full

selective: build_selective trim_selective

none: build_none trim_none


build_full: Dockerfile.build
	docker build -t "prasant/linux-5.15-cfi-full-build" --no-cache -f Dockerfile.build --build-arg FEATURE="-cfi-full" . | tee $@.log

trim_full: Dockerfile.kernel
	docker build -t "prasant/linux-5.15-cfi-full" --no-cache -f Dockerfile.kernel . --build-arg FEATURE="-cfi-full"

build_selective: Dockerfile.build
	docker build -t "prasant/linux-5.15-cfi-selective-build" --no-cache -f Dockerfile.build --build-arg FEATURE="-cfi-selective" . | tee $@.log

trim_selective: Dockerfile.kernel
	docker build -t "prasant/linux-5.15-cfi-selective" --no-cache -f Dockerfile.kernel . --build-arg FEATURE="-cfi-selective"

build_none: Dockerfile.build
	docker build -t "prasant/linux-5.15-cfi-none-build" --no-cache -f Dockerfile.build --build-arg FEATURE="-cfi-none" . | tee $@.log

trim_none: Dockerfile.kernel
	docker build -t "prasant/linux-5.15-cfi-none" --no-cache -f Dockerfile.kernel . --build-arg FEATURE="-cfi-none"

ubuntu: Dockerfile.ubuntu
	docker build -t "prasant/ubuntu" --no-cache -f Dockerfile.ubuntu .

clean:
	rm -rf linuxkit-* *.log *.tar.gz
