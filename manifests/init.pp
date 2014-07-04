#
# kernel
#

sysctl { 'net.ipv6.conf.all.disable_ipv6':
	ensure    => 'present',
	permanent => 'yes',
	value     => '1',
}

sysctl { 'net.ipv6.conf.default.disable_ipv6':
	ensure    => 'present',
	permanent => 'yes',
	value     => '1',
}

sysctl { 'net.ipv6.conf.lo.disable_ipv6':
	ensure    => 'present',
	permanent => 'yes',
	value     => '1',
}


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

