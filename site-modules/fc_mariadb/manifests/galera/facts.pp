# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include fc_mariadb::galera::facts
class fc_mariadb::galera::facts {
  anchor { 'fc_playlister_mariadb::galera::facts::begin': }

  # Using exec instead of file resource to break dependency cycle
  ~> exec { 'create parent directories for facter for playlister_oltp facts...':
    command => "/usr/bin/mkdir -p /etc/facter/facts.d/"
  }
  ~> file { '/etc/facter/facts.d/fc_playlister_oltp.txt':
    ensure => file,
    source => [ "puppet:///modules/fc_common/dynamic_facter/OLTP_$clientcert.txt" ],
    mode => "0600"
  }
  ~> refacter { 'reload after playlister oltp facts placed': patterns => [ "^*" ] }
  ~> anchor { 'fc_playlister_mariadb::galera::facts::end': }
}
