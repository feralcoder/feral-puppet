# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include fc_mariadb::galera::install
class fc_mariadb::galera::install {
  class { 'fc_mariadb::packages': }
  ~> package { [ 'MariaDB-server', 'MariaDB-backup', 'galera-4' ]:
    ensure => installed,
  }
}
