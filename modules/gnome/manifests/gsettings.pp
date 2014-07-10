define gnome::gsettings ($value, $user = 1000) {
	$keys   = split($name, ":")
	$schema = $keys[0]
	$key    = $keys[1]
	$match  = regsubst($value, '([\[\]])', '\\\1', 'G')

	exec { "${name}-exec":
		command     => "/usr/bin/set-gsetting-from-puppet ${schema} ${key} \"${value}\"",
		unless      => "/usr/bin/gsettings get ${schema} ${key} | /bin/grep \"${match}\"",
		user        => $user,
		require     => File["/usr/bin/set-gsetting-from-puppet"],
	}
}

