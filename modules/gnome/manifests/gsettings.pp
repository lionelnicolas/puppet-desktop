define gnome::gsettings ($value, $user = 1000) {
	$keys   = split($name, ":")
	$schema = $keys[0]
	$key    = $keys[1]
	$match  = regsubst($value, '([\[\]])', '\\\1', 'G')
#
#	exec { "${name}-get-dbus-socket-path":
#		command => "/usr/bin/get-dbus-socket-path >/tmp/puppet.${user}.dbus",
#		user    => $user,
#		creates => "/tmp/puppet.${user}.dbus",
#		require => File["/usr/bin/get-dbus-socket-path"],
#	}

	exec { "${name}-exec":
		command     => "/usr/bin/set-gsetting-from-puppet ${schema} ${key} \"${value}\"",
		unless      => "/usr/bin/gsettings get ${schema} ${key} | /bin/grep \"${match}\"",
		user        => $user,
		require     => File["/usr/bin/set-gsetting-from-puppet"],
	}

#	exec { "${name}-exec":
#		command     => ". /tmp/puppet.${user}.dbus && /usr/bin/gsettings set ${schema} ${key} \"${value}\"",
#		unless      => ". /tmp/puppet.${user}.dbus && /usr/bin/gsettings get ${schema} ${key} | /bin/grep \"${match}\"",
#		user        => $user,
#		require     => Exec["${name}-get-dbus-socket-path"],
#	}
}

