# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include fc_mariadb::galera::stop
class fc_mariadb::galera::stop {
  anchor { 'fc_mariadb::galera::stop::begin': }
  ~> service { 'stop galera node':
    name => 'mariadb',
    ensure => 'stopped',
  }
  ~> anchor { 'fc_mariadb::galera::stop::end': }
}
