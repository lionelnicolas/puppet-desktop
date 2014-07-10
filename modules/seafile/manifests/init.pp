class seafile::client {
	packages::deb { "seafile": url => "https://bitbucket.org/haiwen/seafile/downloads/seafile_3.0.4_amd64.deb" }

	file { "/home/${gnome::params::user}/.config/autostart/seafile-applet.desktop":
		ensure  => file,
		source  => "puppet:///modules/seafile/seafile-applet.desktop",
		mode    => 0755,
		owner   => $gnome::params::user,
		group   => $gnome::params::user,
		require => File["/home/${gnome::params::user}/.config/autostart"],
	}
}

