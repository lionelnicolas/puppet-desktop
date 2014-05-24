#!/bin/sh

RESTORE='\033[0m'
RED='\033[01;31m'
GREEN='\033[01;32m'
YELLOW='\033[01;33m'
BLUE='\033[01;34m'

LSB_RELEASE=/etc/lsb-release
TMPDIR=`mktemp -d bootstrap`

fatal() {
	/bin/echo
	/bin/echo -e "${RED}$*${RESTORE}" >&2

	rm -rf ${TMPDIR}

	exit 1
}

logme() {
	/bin/echo
	/bin/echo -e "${GREEN}$*${RESTORE}"
}

# Check user id

if [ "`id -u`" -ne 0 ]; then
	fatal "This script must be run by root or using sudo"
fi

# Detect distribution

logme "Sourcing ${LSB_RELEASE}"

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

logme "Downloading puppet release package"
if ! wget -O${TMPDIR}/puppetlabs-release.deb https://apt.puppetlabs.com/puppetlabs-release-${DISTRIB_CODENAME}.deb; then
	fatal "Failed to download puppet release package"
fi

# Install aptitude as package manager

logme "Installing aptitude package manager"

apt-get -y install aptitude
aptitude update
dpkg -i ${TMPDIR}/puppetlabs-release.deb
apt-get update

