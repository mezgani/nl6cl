#!/bin/make


PYTHON = `which python`
MKDIR  = `which mkdir`
CP     = `which cp`
RM     = `which rm`


all:
	${PYTHON} setup.py install 
	[ -d /usr/share/nl6cl ] || mkdir /usr/share/nl6cl
	${CP} nl6cl.sh /usr/share/nl6cl/
	${CP} nl6cl.conf /etc/
	${CP} nl6cl /usr/local/sbin/
	${RM} -fr build
