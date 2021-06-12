# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include fc_mariadb::galera::join
class fc_mariadb::galera::join {
  anchor { 'fc_mariadb::galera::join::begin': }
  ~> service { 'stop mariadb for preinitialization':
    name => 'mariadb',
    ensure => 'running',
  }
  ~> anchor { 'fc_mariadb::galera::join::end': }
}
