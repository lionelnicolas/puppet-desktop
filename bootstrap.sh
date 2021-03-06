#!/bin/sh

# Exit on failure
set -e

export LANG=C

RESTORE='\033[0m'
RED='\033[01;31m'
GREEN='\033[01;32m'
YELLOW='\033[01;33m'
BLUE='\033[01;34m'

PPWD=${PWD}
LSB_RELEASE=/etc/lsb-release
TMPDIR=`mktemp -d /tmp/bootstrap_XXXXXX`
TGZ=master.tgz
WGET_URL=${WGET_URL:-https://github.com/lionelnicolas/puppet-desktop/tarball/master}

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

is_package_installed() {
	if [ -z "$1" ]; then
		fatal "is_package_installed: No package specified"
	elif dpkg -s $1 2>&1 | grep -q 'Status: install ok installed'; then
		return 0
	fi

	return 1
}

install_puppet_module() {
	SOURCE=$1
	MODULE=`echo $1 | cut -d- -f2-`

	if [ -z "$1" ]; then
		fatal "install_puppet_module: No puppet module specified"
	elif [ ! -d /etc/puppet/modules/${MODULE} ]; then
		puppet module install ${SOURCE} || fatal "install_puppet_module: Failed to install puppet module '${SOURCE}'"
	else
		echo "install_puppet_module: Puppet module ${SOURCE} is already installed"
	fi
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

if is_package_installed puppetlabs-release; then
	logme "Puppet release package is already installed"

else
	logme "Downloading puppet release package"

	if ! wget -O${TMPDIR}/puppetlabs-release.deb https://apt.puppetlabs.com/puppetlabs-release-${DISTRIB_CODENAME}.deb; then
		fatal "Failed to download puppet release package"
	fi

	logme "Installing puppet release package"

	dpkg -i ${TMPDIR}/puppetlabs-release.deb
	apt-get update
fi

# Install aptitude as package manager

if is_package_installed aptitude; then
	logme "Aptitude package is already installed"

else
	logme "Installing aptitude package manager"

	apt-get -y install aptitude
	aptitude update
fi

# Install puppet

if is_package_installed puppet; then
	logme "Puppet package is already installed"

else
	logme "Installing puppet"

	aptitude -y install puppet
fi

# Install puppet modules

logme "Installing puppet modules"

install_puppet_module puppetlabs-apt

# Get puppet manifests

cd ${TMPDIR}

if [ -z "${GIT_URL}" ]; then
	logme "Getting puppet manifests from tarball ${WGET_URL}"
	wget --output-document ${TGZ} ${WGET_URL}
	tar xf ${TGZ} --strip 1
	rm -f ${TGZ}
else
	logme "Getting puppet manifests from git ${GIT_URL}"

	if ! is_package_installed git-core; then
		aptitude -y install git-core
	fi

	git clone ${GIT_URL} .
fi

if [ -n "${INIT_URL}" ]; then
	logme "Overriding init manifest with ${INIT_URL}"
	wget --output-document manifests/init.pp ${INIT_URL}
fi

# Apply puppet manifests

MODULEPATH=`puppet config print modulepath`
puppet apply manifests/ --modulepath ${MODULEPATH}:${PWD}/modules

# Clean

cd ${PPWD}
rm -rf ${TMPDIR}

logme "Done."

