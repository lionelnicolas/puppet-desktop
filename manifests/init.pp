# kernel

include sysctl::disable_ipv6


# packages

include packages
include packages::aptitude

include packages::dev
include packages::libs
include packages::system
include packages::vcs
include packages::archive
include packages::stats
include packages::shell
include packages::multimedia
include packages::ui
include packages::network
include packages::editors
include packages::virtualization

include chrome


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
#



#
#
