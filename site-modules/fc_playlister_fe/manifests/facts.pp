# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include fc_playlister_fe::facts
class fc_playlister_fe::facts {
  anchor { 'fc_playlister_fe::facts::begin': }

  # Using exec instead of file resource to break dependency cycle
  ~> exec { 'create parent directories for facter for playlister_fe facts...':
    command => "/usr/bin/mkdir -p /etc/facter/facts.d/"
  }
  ~> file { '/etc/facter/facts.d/fc_playlister_fe.txt':
    ensure => file,
    source => [ "puppet:///modules/fc_common/dynamic_facter/FE_$clientcert.txt" ],
    mode => "0600"
  }
  ~> refacter { 'reload after playlister fe facts placed': patterns => [ "^*" ] }
  ~> anchor { 'fc_playlister_fe::facts::end': }
}
