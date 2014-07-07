class chrome {
	apt::source { "chrome_apt_repository":
		location    => 'http://dl.google.com/linux/chrome/deb/',
		release     => 'stable',
		key_source  => 'http://dl-ssl.google.com/linux/linux_signing_key.pub',
		key         => '7FAC5991',
		repos       => 'main',
		include_src => false,
	}
}

