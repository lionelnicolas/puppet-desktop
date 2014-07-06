class sysctl {
	exec { "sysctl-reload":
		command     => "/sbin/sysctl -p",
		refreshonly => true,
	}
}

class sysctl::disable_ipv6 {
	sysctl::set {'net.ipv6.conf.all.disable_ipv6':     value => '1'}
	sysctl::set {'net.ipv6.conf.default.disable_ipv6': value => '1'}
	sysctl::set {'net.ipv6.conf.lo.disable_ipv6':      value => '1'}
}

