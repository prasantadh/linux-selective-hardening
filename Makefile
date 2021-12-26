all: kernel-build

kernel-build: Dockerfile
	docker build -t "prasant/kernel-build" --no-cache .
