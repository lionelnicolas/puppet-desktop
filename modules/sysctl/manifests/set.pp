define sysctl::set ($value) {
	exec { "${name}-exec":
		command => "/bin/grep -q '^${name}.*=.*' /etc/sysctl.conf && /bin/sed -i 's/^${name}.*=.*/${name} = ${value}/' /etc/sysctl.conf || echo '${name} = ${value}' >> /etc/sysctl.conf",
		unless  => "/bin/grep -q '^${name}.*=.*${value}' /etc/sysctl.conf",
	}
}

