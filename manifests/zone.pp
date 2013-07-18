# Define: gdnsd::zone
#
# Install gdnsd zone files.
#
# Example :
#   gdnsd::zone { 'example.com':
#     source => 'puppet:///modules/mymodule/dns/example.com',
#   }
#   gdnsd::zone { [ 'example.net', 'example.org' ]:
#     source_base => 'puppet:///modules/mymodule/dns/',
#   }
#
define gdnsd::zone (
  $ensure      = undef,
  $source      = undef,
  $source_base = undef,
  $content     = undef,
  $mode        = '0640'
) {

  if $source      { $zone_source = $source }
  if $source_base { $zone_source = "${source_base}${title}" }

  file { "/etc/gdnsd/zones/${title}":
    owner   => 'root',
    group   => 'root',
    mode    => $mode,
    source  => $zone_source,
    content => $content,
    notify  => Service['gdnsd'],
    # For the parent directory
    require => Package['gdnsd'],
    ensure  => $ensure,
  }

}

