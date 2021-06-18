# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include fc_mariadb::galera::initialize
class fc_mariadb::galera::initialize {
  anchor { 'fc_mariadb::galera::initialize::begin': }

  ~> file { '/tmp/playlister-galera-new-db.sql':
    ensure => file,
    content => template('fc_mariadb/playlister-galera-new-db.sql'),
    mode => '0600',
  }
  ~> exec { 'initialize playlister DB from script':
    command => "/usr/bin/mysql --user root < /tmp/playlister-galera-new-db.sql",
  }
  ~> anchor { 'fc_mariadb::galera::initialize::end': }
}
