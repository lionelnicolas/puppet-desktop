class puppet::fixwarning {
	exec { 'puppet-fix-templatedir-warning':
		command => "/bin/sed -ri 's/^templatedir/#templatedir/' /etc/puppet/puppet.conf",
		onlyif  => "/bin/grep ^templatedir /etc/puppet/puppet.conf",
	}

	exec { 'puppet-fix-non-existing-hiera-config':
		command => "/bin/touch /etc/puppet/hiera.yaml",
		onlyif  => "/usr/bin/test ! -f /etc/puppet/hiera.yaml",
	}
}

