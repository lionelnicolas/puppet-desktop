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

