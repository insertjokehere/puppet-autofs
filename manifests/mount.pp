# Define: autofs::mount
# Parameters:
# arguments
#
define autofs::mount ($targetdir=$name, $source, $fstype="",$options="", $mapfile) {
	
	if ($source =~ /^\//) {
		$realsource = ":${source}"
	} else {
		$realsource = $source
	}

	#todo: templates
	if ($fstype != "") and ($options !="") {
		$optstring = "-fstype=${fstype},${options}"
	} elsif($fstype != "") {
		$optstring = "-fstype=${fstype}"
	} elsif($options != "") {
		$optstring = $options
	} else { 
		$optstring = ""
	}

	concat::fragment { "${targetdir}_${source}":
		target => $mapfile,
		content => "${targetdir}\t${optstring}\t${realsource}\n"
	}

}