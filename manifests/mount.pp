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

	#this is probably more complex than it needs to be
	if ($fstype == "" && $options="") {
		$optstring = ""
	} elsif($fstype != "") {
		$optstring = "-fstype=${fstype}"
	} elsif($options != "") {
		$optstring = $options
	} else {
		$optstring = "-fstype=${fstype},${options}"
	}

	concat::fragment { "${targetdir}_${source}":
		target => $mapfile,
		content => "${targetdir}\t${optstring}\t${realsource}\n"
	}

}