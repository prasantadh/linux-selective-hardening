import argparse
import sys
import yaml
import json
import os

parser = argparse.ArgumentParser(description=
        'driver for profiling/benchmarking the selectively hardened kernel' )

parser.add_argument('--action', choices=['benchmark', 'build', 'profile'],
        required=True,
        help='choose whether to get gcov profile or to get benchmark results')

parser.add_argument('--target',
        help='use with --build to specify kernel or '
        choices=['kernel', 'container'],
        default=False)

parser.add_argument('--build-container',
        help='build the container with selected benchmark',
        action='store_true',
        default=False)

parser.add_argument('--suite', choices=['ubuntu', 'nas', 'phoronix',  'spec'],
        help=('choose which benchmark suite to run (nas, phoronix or spec 2006 cpu). '
            'choosing ubuntu will run the latest ubuntu container without any payload'))

parser.add_argument('--mitigation', choices=['stackguard', 'cfi'],
        help='ignored for profiling (not relevant). '
                'for building, relevant kernel configs are adjusted. '
                'for benchmarking, relevant images are pulled into linuxkit')

parser.add_argument('--level', choices=['none', 'selective', 'full'],
        help='use with --mitigation to apply relevant level of mitigation. ',
        default="full")

args = parser.parse_args()

def add_file(name):
    template['files'].append({
        'path'  : name,
        'source': name,
        'mode'  : "0755"
        })

def update_kernel():
    if args.action == 'profile':
        template['kernel']['image'] = 'tracks/linux-5.15-gcov:latest'
    else:
        template['kernel']['image'] = 'tracks/linux-5.15-{}-{}:latest'.format(args.mitigation, args.level)

def add_service(name):
    template['services'].append({
        'name'  : name,
        'image' : 'tracks/{}:latest'.format(args.suite),
        'env'   : [ name.upper() + '=true' ],
        'command'   : ['/bin/sh', '-c', '/usr/bin/sleep infinity'],
        'capabilities' : ['ALL'],
        'binds' : ['/etc/resolv.conf:/etc/resolv.conf',
                    '/{}.sh:/root/{}.sh'.format(args.action, args.action),
                    '/qemu-ssh-access:/root/.ssh/id_ed25519']
        })

if args.build_kernel:
    cmd = "docker build --target kernel-build --no-cache "
    if args.action == 'profile':
        cmd += "--build-arg FEATURE=-gcov -t tracks/linux-gcov "

        status = os.system(cmd)

    if args.action == 'benchmark':
        # build the kernel with desired mitigation level
        if args.mitigation:
            cmd += ( f"--build-arg FEATURE=-{args.mitigation} "
                     f"--build-arg LEVEL=-{args.level} "
                     f"--build-arg COMPILER='LLVM=1' "
                     f"-t linux-{args.mitigation}-{args.level} " )

    cmd += "-f Dockerfile.kernel ."
    print(cmd)
    os.system(cmd)

elif args.build_container:
        cmd = 'docker build --target {} -t tracks/{} -f Dockerfile.benchmark .'.format(
                args.suite,
                args.suite
                )
        status = os.system(cmd)

else:
    with open('linuxkit.yml.template', 'r') as stream:
        template = yaml.safe_load(stream)

    update_kernel()
    add_service(args.suite)
    add_file(args.action + '.sh')

    with open('linuxkit.yml', 'w') as config_file:
        yaml.dump(template, config_file)

    print(json.dumps(template, indent=4))
