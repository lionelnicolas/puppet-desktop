#!/bin/sh

LSB_RELEASE=/etc/lsb-release
TMPDIR=`mktemp -d bootstrap`

fatal() {
	echo "$*"
	exit 1
}

# Check user id

if [ "`id -u`" -ne 0 ]; then
	fatal "This script must be run by root or using sudo"
fi

# Detect distribution

if [ ! -f ${LSB_RELEASE} ]; then
	fatal "Unable to find ${LSB_RELEASE}"
fi

. ${LSB_RELEASE}

if [ "${DISTRIB_ID}" != "Ubuntu" ]; then
	fatal "This script must be run on Ubuntu"
fi

if [ -z "${DISTRIB_CODENAME}" ]; then
	fatal "DISTRIB_CODENAME is not set"
fi

# Install puppet repository

if ! wget -O${TMPDIR}/puppetlabs-release.deb https://apt.puppetlabs.com/puppetlabs-release-${DISTRIB_CODENAME}.deb; then
	fatal "Failed to download puppet release package"
fi

dpkg -i ${TMPDIR}/puppetlabs-release.deb
apt-get update

