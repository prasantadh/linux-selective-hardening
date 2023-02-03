import argparse
import sys
import yaml
import json

parser = argparse.ArgumentParser()

subparsers = parser.add_subparsers( title="subcommands")
subparsers.dest = 'command'
parser_profile = subparsers.add_parser('profile',
                    help="python3 driver.py profile [ -h | --help ]")
parser_benchmark = subparsers.add_parser('benchmark',
                    help="python3 driver.py benchmark [ -h | --help ]")

# suite = parser_profile.add_mutually_exclusive_group()
suite = parser_profile.add_argument_group()
suite.add_argument('--none',
                    help='get profile without running any benchmarks.'
                    'this option is ignored in presence of any other workload',
                    action='store_true')
suite.add_argument('--all',
                    help='get profile by running all three benchmarks',
                    action='store_true')
suite.add_argument('--nas',
                    help='get profile by running NAS parallel benchmarks',
                    action='store_true')
suite.add_argument('--phoronix',
                    help='get profile by running phoronix benchmarks',
                    action='store_true')
suite.add_argument('--spec',
                    help='get profile by running SPEC CPU 2006 benchmarks',
                    action='store_true')

if len(sys.argv) < 2:
    parser.parse_args(['-h'])
    sys.exit(1)

def profile():
    if args.all:
        args.nas = True
        args.phoronix = True
        args.spec = True

    service = lambda name:  {
            'name'  : name,
            'image' : 'prasant/' + name + ':latest',
            'env'   : [ name.upper() + '=true' ],
            'command' : ['/bin/sh', '-c', '/bin/sleep infinity'],
            'capabilities' : ['ALL'],
            'binds' : ['/etc/resolv.conf:/etc/resolv.conf',
                        '/gather-on-test.sh:/root/gather-on-test.sh',
                        '/qemu-ssh-access:/root/.ssh/id_ed25519']
            }
    print(service("nas"))
    with open('linuxkit.yml.template', 'r') as stream:
        template = yaml.safe_load(stream)

    if args.nas:
        template['services'].append(service("nas"))
    if args.phoronix:
        template['services'].append(service("phoronix"))
    if args.spec:
        template['services'].append(service("spec"))

    with open('linuxkit.yml', 'w') as config_file:
        yaml.dump(template, config_file)

args = parser.parse_args()
if args.command == 'profile':
    profile()
else:
    benchmark()
