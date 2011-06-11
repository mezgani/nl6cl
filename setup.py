#!/usr/bin/python2

from distutils.core import setup, Extension

ethtool = Extension('ifconfig',
		    sources = ['ifconfig.c'])

# don't reformat this line, Makefile parses it
setup(name='ifconfig',
      version='0.1',
      description='Python module to ifconfig with ioctl',
      author='MEZGANI Ali',
      author_email='mezgani@nativelabs.org',
      url='http://www.nativelabs.org/',
      ext_modules=[ethtool])
