class packages (
	$has_X = true,
) {
	class { 'apt': }
}

class packages::dev {
	package { [
		'build-essential',
		'default-jdk',
		'ipython',
		]:
			ensure => installed,
	}

	if $packages::has_X {
		package { [
			'mysql-workbench',
			]:
				ensure => installed,
		}
	}
}

class packages::libs {
	package { [
		'libjansson4',
		]:
			ensure => installed,
	}
}

class packages::system {
	package { [
		'ca-certificates',
		'kpartx',
		'most',
		'pwgen',
		]:
			ensure => installed,
	}

	if $packages::has_X {
		package { [
			'gparted',
			]:
				ensure => installed,
		}
	}
}

class packages::vcs {
	package { [
		'git-core',
		'git-gui',
		'git-stuff',
		'tig',
		'mercurial',
		'subversion',
		'gitk',
		]:
			ensure => installed,
	}
}

class packages::archive {
	package { [
		'p7zip',
		'rar',
		'unrar',
		'unzip',
		'zip',
		]:
			ensure => installed,
	}
}

class packages::stats {
	package { [
		'bwm-ng',
		'dstat',
		'htop',
		'iftop',
		'iotop',
		'iptraf',
		]:
			ensure => installed,
	}
}

class packages::shell {
	package { [
		'bash-completion',
		'screen',
		'zsh',
		]:
			ensure => installed,
	}
}

class packages::multimedia {
	package { [
		'clementine',
		'flashplugin-installer',
		'gstreamer0.10-plugins-bad',
		'gstreamer0.10-plugins-ugly',
		'gstreamer1.0-plugins-bad',
		'gstreamer1.0-plugins-ugly',
		'inkscape',
		'pinta',
		'ubuntu-restricted-extras',
		'vlc',
		]:
			ensure => installed,
	}
}

class packages::ui {
	package { [
		'gnome-shell',
		'gnome-shell-extensions',
		'gnome-shell-extension-weather',
		'gnome-shell-timer',
		'nemo',
		'network-manager-openvpn',
		'terminator',
		'tomboy',
		]:
			ensure => installed,
	}
}

class packages::network {
	package { [
		'nmap',
		'openssh-server',
		'openvpn',
		'python-scapy',
		'sshfs',
		'whois',
		]:
			ensure => installed,
	}

	if $packages::has_X {
		package { [
			'filezilla',
			'transgui',
			'wireshark',
			]:
				ensure => installed,
		}
	}
}

class packages::editors {
	package { [
		'vim',
		'vim-puppet',
		'vim-scripts',
		]:
			ensure => installed,
	}
}

class packages::virtualization {
	package { [
		'lxc',
		'lxc-templates',
		'lxctl',
		'virt-top',
		]:
			ensure => installed,
	}

	if $packages::has_X {
		package { [
			'virt-manager',
			'virt-viewer',
			]:
				ensure => installed,
		}
	}
}

