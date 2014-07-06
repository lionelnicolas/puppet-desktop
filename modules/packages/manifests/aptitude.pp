class packages::aptitude {
	exec { 'aptitude-update':
		command     => "/usr/bin/aptitude update",
		refreshonly => true,
	}

	exec { 'apt-remove-src':
		command => "/bin/sed -ri 's/^deb\\-src/# deb-src/' /etc/apt/sources.list",
		onlyif  => "/bin/grep ^deb-src /etc/apt/sources.list",
		notify  => Exec['aptitude-update'],
	}

	file { '/etc/apt/apt.conf.d/90custom':
		ensure  => file,
		content => "
			Acquire::Languages \"none\";
		",
		mode    => 0644,
		notify  => Exec['aptitude-update'],
	}
}

