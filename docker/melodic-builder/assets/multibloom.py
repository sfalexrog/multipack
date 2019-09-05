#!/usr/bin/env python

from __future__ import print_function
from catkin_pkg.topological_order import topological_order
import os
import subprocess

ROS_VERSION = 'melodic'
PATH_PREFIX = os.path.abspath('') + '/src/'


def rosify(package_name):
    return ("ros-%s-" % ROS_VERSION) + package_name.replace("_", "-")


def generate_package(package):
    print("Generating rules for %s" % package[0])
    package_path = PATH_PREFIX + package[0]
    os.chdir(package_path)
    result = subprocess.call(['bloom-generate',
                              'rosdebian',
                              '--os-name',
                              'debian',
                              '--os-version',
                              'buster',
                              '--ros-distro',
                              'melodic'])
    print('Done; result is %d' % result)
    print('Creating package for %s' % package[0])
    result = subprocess.call(['fakeroot',
                              'debian/rules',
                              'binary'])
    print('Done; result is %d' % result)
    # FIXME: Defer installation until exec dependencies are built (if that is possible at all)
    #print('Installing package for %s' % package[0])
    #os.chdir(os.path.abspath(package_path + '/..'))
    #result = subprocess.call("find -iname '%s*.deb' -exec apt install {} \\;" % rosify(package[1].name),
    #                         shell=True)
    #print('Done; result is %d' % result)
    return result


def generate_rosdep(package_list):
    for package in package_list:
        rosified_name = rosify(package[1].name)
        print("%s:" % package[1].name)
        print("  debian:")
        print("    buster: %s" % rosified_name)


def print_usage():
    print('Usage: multibloom.py rosdep | generate\n'
          'Verb meanings:\n'
          '  rosdep   - Generate a rosdep yaml file for\n'
          '             the packages in src\n'
          '  generate - Build .deb packages for all\n'
          '             packages in src\n')


if __name__ == '__main__':
    if len(os.sys.argv) < 2:
        print_usage()
        exit(1)
    packages = topological_order(PATH_PREFIX)
    if os.sys.argv[1] == 'rosdep':
        generate_rosdep(packages)
    elif os.sys.argv[1] == 'generate':
        for package in packages:
            generate_package(package)
    else:
        print_usage()
        exit(1)
