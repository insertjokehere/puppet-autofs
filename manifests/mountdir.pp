# Define: autofs::mountdir
# Parameters:
# arguments
#
define autofs::mountdir ($dir=$name, $mapfile, $timeout=2, $options="") {
	
	if ($options == ""){
		$optdelmed = ""
	} else {
		$optdelmed = ",${options}"
	}

	concat::fragment { $dir:
		target => "/etc/autofs.master",
		content => "${dir}\t${mapfile}\t--timeout=${timeout}${optdelmed}"
	}

}