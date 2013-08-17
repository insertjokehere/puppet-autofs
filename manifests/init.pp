# Class: autofs
#
#
class autofs {
	
	package { "autofs":
		ensure => installed,
	}

	service { "autofs":
	    enable => true,
		ensure => running,
		require => Package["autofs"],
	}

	concat { "/etc/autofs.master":
		owner => "root",
		group => "root",
		mode  => "0644",
		notify => Service["autofs"]
	}

}