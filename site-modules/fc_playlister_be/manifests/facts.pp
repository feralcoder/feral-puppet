# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include fc_playlister_be::facts
class fc_playlister_be::facts {
  # Using exec instead of file resource to break dependency cycle
  exec { 'create parent directories for facter for playlister_be facts...':
    command => "/usr/bin/mkdir -p /etc/facter/facts.d/"
  }
  file { '/etc/facter/facts.d/fc_playlister_be.txt':
    ensure => file,
    source => [ "puppet:///modules/fc_playlister_be/dynamic_facter/$clientcert.txt" ],
    mode => "0600"
  }
  ~> refacter { 'reload after playlister facts placed': patterns => [ "^*" ] }
  anchor { 'fc_playlister_be::facts::end': }
}
