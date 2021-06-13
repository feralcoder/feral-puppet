# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include fc_mariadb::galera::start
class fc_mariadb::galera::start {
  anchor { 'fc_mariadb::galera::start::begin': }
  ~> service { 'start galera node':
    name => 'mariadb',
    ensure => 'running',
  }
  ~> anchor { 'fc_mariadb::galera::start::end': }
}
