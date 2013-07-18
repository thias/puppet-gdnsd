# puppet-gdnsd

## Overview

Install, enable and configure the gdnsd DNS server.

* `gdnsd` : Main class to install, enable and configure the server.
* `gdnsd::zone` : Definition to manage zone files.

## Examples

Install and enable the server (for the ip_nonlocal_bind to work, you will need
the sysctl module), using the included template for the main configuration :

    $options = {
      'listen' => '[ 127.0.0.1 ]',
    }
    class { 'gdnsd':
      config_content   => template('gdnsd/config.erb'),
      ip_nonlocal_bind => true,
    }

Install a single zone file :

    gdnsd::zone { 'example.com':
      source => 'puppet:///modules/mymodule/dns/example.com',
    }

For multiple source-based files, use the `$source_base` parameter to be able
to use an array of zone names :

    gdnsd::zone { [ 'example.com', 'example.net', 'example.org' ]:
      source_base => 'puppet:///modules/mymodule/dns/',
    }

For more information, including help and configuration examples, see :
https://github.com/blblack/gdnsd

