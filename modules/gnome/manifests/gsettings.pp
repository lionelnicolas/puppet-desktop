define gnome::gsettings ($value) {
	$keys   = split($name, ":")
	$schema = $keys[0]
	$key    = $keys[1]
	$match  = regsubst($value, '([\[\]])', '\\\1', 'G')

	exec { "${name}-exec":
		command     => "/usr/bin/set-gsetting-from-puppet ${schema} ${key} \"${value}\"",
		unless      => "/usr/bin/gsettings get ${schema} ${key} | /bin/grep \"${match}\"",
		user        => $gnome::params::user,
		require     => File["/usr/bin/set-gsetting-from-puppet"],
	}
}

