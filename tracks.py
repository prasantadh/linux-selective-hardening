import argparse
import sys
import yaml
import json
import os
import warnings

def update_kernel(template, kernel):
    template['kernel']['image'] = kernel

def add_file(template, filename):
    template['files'].append({
        'mode'  : "0755",
        'path'  : filename,
        'source': filename
        })

def add_service(template):
    template['services'].append({
        'binds' : [ '/etc/resolv.conf:/etc/resolv.conf',
                    '/qemu-ssh-access:/root/.ssh/id_ed25519',
                    f'/{args.action}.sh:/root.{args.action}.sh' ],
        'command'   : [ '/bin/sh', '-c', '/usr/bin/sleep infinity' ],
        'capabilities'  : ['ALL'],
        'env'   : [ f'{args.suite.upper()}=true', f'ACTION={args.action}' ],
        'image' : f'tracks/{args.suite}:latest',
        'name'  : f'tracks/{args.suite}'
        })

run = lambda : os.system('linuxkit build -disable-content-trust linuxkit.yml && '
        'linuxkit run qemu -mem 32768 -cpus 8 linuxkit')

def build(args):
    assert args.kernel or args.container, '--kernel or --container required'
    if (args.kernel):
        cmd = 'docker build --target kernel-build --no-cache '
        if args.mitigation is None:
            assert args.level is None, '--level not allowed without --mitigation'
            cmd += '-t tracks/linux '
        else:
            cmd += f'--build-arg FEATURE=-{args.mitigation} '
            if args.mitigation == 'gcov':
                assert args.level is None, '--level not allowed with --mitigation=gcov'
                cmd += f"-t tracks/linux-{args.mitigation} "
            else:
                assert args.level is not None, '--level required'
                cmd += f"--build-arg COMPILER='LLVM=1' "
                cmd += f"-t linux-{args.mitigation}-{args.level} "
        cmd += "-f Dockerfile.kernel ."
    else:
        cmd = ( f'docker build --target {args.suite} '
                f'-t tracks/{args.suite} '
                f'-f Dockerfile.benchmark .' )
    print(cmd)
    status = os.system(cmd)

def benchmark(args):

    with open('linuxkit.yml.template', 'r') as stream:
        template = yaml.safe_load(stream)

    if args.mitigation and args.level:
        kernel = 'tracks/linux-{}-{}:latest'.format(args.mitigation, args.level)

    update_kernel(template, kernel)
    add_file(template, 'benchmark.sh')
    run()

def profile(args):
    with open('linuxkit.yml.template', 'r') as stream:
        template = yaml.safe_load(stream)

    update_kernel(template, 'tracks/linux-gcov:latest')
    add_file(template, 'profile.sh')
    add_service(template)

    with open('linuxkit.yml', 'w') as config_file:
        yaml.dump(template, config_file)
    run()


parser = argparse.ArgumentParser(description=
        'driver to build/profile/benchmark the selectively hardened kernel' )

action_parser = parser.add_subparsers(dest='action', required=True)

# benchmark options parser
benchmark_parser = action_parser.add_parser('benchmark')
benchmark_parser.add_argument('--suite',
        choices = ['nas', 'phoronix', 'spec', 'ubuntu'],
        help="choose a payload to build. default is ubuntu",
        default='ubuntu')
benchmark_parser.add_argument('--mitigation',
        choices = ['cfi', 'stackguard'],
        help="choose a mitigation to apply")
benchmark_parser.add_argument('--level',
        choices = ['selective', 'full'],
        help="choose a level for --mitigation")
benchmark_parser.set_defaults(func=benchmark)

# build options parser
build_parser = action_parser.add_parser('build')
build_target_group = build_parser.add_argument_group('build targets (dafault --kernel)')
build_target_group.add_argument('--kernel',
        help="build kernel with gcov (default) or with a --mitigation --level",
        action='store_true',
        default=False)
build_target_group.add_argument('--container',
        help="build container with ubuntu (default) or a benchmark --suite",
        action='store_true')

kernel_options = build_parser.add_argument_group('kernel options')
kernel_options.add_argument('--mitigation',
        choices = ['cfi', 'stackguard'],
        help="choose a mitigation to apply")
kernel_options.add_argument('--level',
        choices = ['selective', 'full'],
        help="choose a level for --mitigation")

container_options = build_parser.add_argument_group('container options')
container_options.add_argument('--suite',
        choices = ['nas', 'phoronix', 'spec', 'ubuntu'],
        help="choose a payload to build. default is ubuntu",
        default='ubuntu')

build_parser.set_defaults(func=build)

# profile options parser
profile_parser = action_parser.add_parser('profile')
profile_parser.add_argument('--suite',
        choices = ['nas', 'phoronix', 'spec', 'ubuntu'],
        help="choose a payload to build. default is ubuntu",
        default='ubuntu')
profile_parser.set_defaults(func=profile)

args = parser.parse_args()
args.func(args)
