#!/bin/make


PYTHON = `which python`
MKDIR  = `which mkdir`
CP     = `which cp`
RM     = `which rm`


all:
	# Run the setup install
	${PYTHON} setup.py install

	# Create /usr/share/nl6cl is it is not exist
	[ -d /usr/share/nl6cl ] || mkdir /usr/share/nl6cl

	# Move the script nl6cl to the directory
	${CP} nl6cl.sh /usr/share/nl6cl/

	# Move the conf file to /etc directory
	[ -e /etc/nl6cl.conf ] ||  ${CP} nl6cl.conf /etc/

	# Move the nl6cl binary to /usr/local/sbin
	${CP} nl6cl /usr/local/sbin/

	#Remove build directory
	${RM} -fr build
