##########
# kernel #
##########

include sysctl::disable_ipv6


############
# packages #
############

# apt/aptitude configuration
include packages
include packages::aptitude

# install usefull packages
include packages::dev
include packages::libs
include packages::system
include packages::vcs
include packages::archive
include packages::stats
include packages::shell
include packages::multimedia
include packages::ui
include packages::network
include packages::editors
include packages::virtualization

include chrome
include seafile::client



##########
# puppet #
##########

include puppet::fixwarning


#########
# gnome #
#########

class { "gnome::params":
	user             => "lionel",
	weather_tempunit => "celsius",
}

include gnome
include gnome::theme
include gnome::clock
include gnome::weather

