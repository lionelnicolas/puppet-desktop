#
# Custom defines and classes
#

define http::deb ($url, $depends = false) {
	exec { "${name}-download":
		command => "/usr/bin/wget -q -O/tmp/${name}.deb ${url}",
		creates => "/tmp/${name}.deb",
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
}


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


#
# apt/aptitude
#

class { 'apt': }

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


#

#
# google chrome
#

class { 'google_chrome': }


#
# Seafile client
#

http::deb { "seafile": url => "https://bitbucket.org/haiwen/seafile/downloads/seafile_3.0.4_amd64.deb" }

