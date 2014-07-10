class gnome {
	file { "/usr/bin/get-dbus-socket-path":
		source => "puppet:///modules/gnome/get-dbus-socket-path",
		mode   => 0755,
		owner  => "root",
		group  => "root",
	}

	file { "/usr/bin/set-gsetting-from-puppet":
		source => "puppet:///modules/gnome/set-gsetting-from-puppet",
		mode   => 0755,
		owner  => "root",
		group  => "root",
	}
}

class gnome::params (
	$user,
	$theme             = 'Adwaita',
	$weather_city      = "3534>Montreal, Quebec (CA)",
	$weather_tempunit  = "celsius",
	$weather_windunit  = "kph",
	$weather_pressunit = "hPa",
) {
}

class gnome::theme {
	gnome::gsettings { "org.gnome.desktop.wm.preferences:theme":   value => $gnome::params::theme }
	gnome::gsettings { "org.gnome.desktop.interface:cursor-theme": value => $gnome::params::theme }
	gnome::gsettings { "org.gnome.desktop.interface:gtk-theme":    value => $gnome::params::theme }
}

class gnome::clock {
	gnome::gsettings { "org.gnome.desktop.interface:clock-show-seconds": value => "true" }
	gnome::gsettings { "org.gnome.desktop.interface:clock-show-date":    value => "true" }
	gnome::gsettings { "org.gnome.shell.calendar:show-weekdate":         value => "true" }
}

class gnome::weather {
	gnome::gsettings { "org.gnome.shell:enabled-extensions":                 value => "[\'weather-extension@jenslody.de\']" }
	gnome::gsettings { "org.gnome.shell.extensions.weather:unit":            value => $gnome::params::weather_tempunit }
	gnome::gsettings { "org.gnome.shell.extensions.weather:wind-speed-unit": value => $gnome::params::weather_windunit }
	gnome::gsettings { "org.gnome.shell.extensions.weather:city":            value => $gnome::params::weather_city }
	gnome::gsettings { "org.gnome.shell.extensions.weather:pressure-unit":   value => $gnome::params::weather_pressunit }
}

