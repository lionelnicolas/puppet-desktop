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
# Seafile client
#

http::deb { "seafile": url => "https://bitbucket.org/haiwen/seafile/downloads/seafile_3.0.4_amd64.deb" }

