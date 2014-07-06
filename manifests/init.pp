#
# Custom defines and classes
#

#
# kernel
#


include sysctl::disable_ipv6

include packages
include packages::aptitude


#
# puppet
#

exec { 'puppet-fix-templatedir-warning':
	command => "/bin/sed -ri 's/^templatedir/#templatedir/' /etc/puppet/puppet.conf",
	onlyif  => "/bin/grep ^templatedir /etc/puppet/puppet.conf",
}

exec { 'puppet-fix-non-existing-hiera-config':
	command => "/bin/touch /etc/puppet/hiera.yaml",
	onlyif  => "/usr/bin/test ! -f /etc/puppet/hiera.yaml",
}


#
#



#

#
# google chrome
#

class { 'google_chrome': }


#
#
