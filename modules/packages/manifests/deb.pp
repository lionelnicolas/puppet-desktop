define packages::deb ($url, $depends = false) {
	exec { "${name}-download":
		command => "/usr/bin/wget -q -O/tmp/${name}.deb ${url}",
		unless  => "/usr/bin/dpkg -s ${name} || /usr/bin/test -f /tmp/${name}.deb",
	}

	package { "${name}":
		ensure   => installed,
		provider => dpkg,
		source   => "/tmp/${name}.deb",
		require  => $depends ? {
			false   =>  Exec["${name}-download"],
			default => [Exec["${name}-download"], Package[$depends]],
		}
	}

	exec { "${name}-fix-dependencies":
		command => "/usr/bin/apt-get install -f -y ${name}",
		unless  => "/usr/bin/dpkg -s ${name} | /bin/grep -q 'Status: install ok installed'",
		require => Package["${name}"],
	}
}

