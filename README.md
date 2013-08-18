puppet-autofs
=============

Autofs Module for Puppet

## Requirements

 * [concat](https://github.com/puppetlabs/puppetlabs-concat)
 * Debian (tested on Wheezy, should work OK on Squeeze as well)

## Types

### class `autofs`

This class manages installing the autofs package, starting the autofs service and defines the master template file. It has no parameters, and must be included on any node that uses any of the other types defined in the module

### define `autofs::mountdir`

This defines a directory to hold the autofs mount points, creates the necessary entries in the master template file, and creates its own template file.

Parameters:
 * `dir` => the path to the mount directory. If not specified, uses the name used for the define
 * `mapfile` => the path to create the template file. By convention, this should be `/etc/auto.<something>`. It is required.
 * `timeout` => the number of seconds to wait before unmounting directories
 * `options` => any additional options to specify. See `auto.master(5)` and `autofs(5)` for details

### define `autofs::mount`

This defines a resource that should be mounted inside a mount directory. It creates the necessary entry in the template file of the mount dir.

Parameters:
 * `targetdir` => the name the resource should be mounted as. Uses the name used for the define if not specified
 * `source` => the source path of the resource. Could be the path to a device node, a UNC path, etc. Required
 * `fstype` => the type of the filesystem to be mounted (ie, what you would put in `fstab`), unless using nfs when this option can be omitted.
 * `options` => any options to be added to the mount entry
 * `mapfile` => the mapfile used for the mountdir this resource should be mounted in
 * 
 
## Example

	include autofs

	autofs::mountdir { "/media":
		mapfile => "/etc/auto.media",
		timeout => 6000,
		options => "--ghost",
	}

	autofs::mount { "accounting":
		source => "//accounting/shared",
		fstype => "cifs",
		options => "credentials=/etc/auto.auth,file_mode=0770,nounix,uid=555,gid=555",
		mapfile => "/etc/auto.media",
	}

	autofs::mount { "sales":
		source => "//sales/shared",
		fstype => "cifs",
		options => "credentials=/etc/auto.auth,file_mode=0770,nounix,uid=555,gid=555",
		mapfile => "/etc/auto.media",
	}
