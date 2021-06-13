# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include fc_mariadb::columnstore::stop
class fc_mariadb::columnstore::stop {
  anchor { 'fc_mariadb::columnstore::stop::begin': }
  ~> service { 'stop columnstore node':
    name => 'mariadb',
    ensure => 'stopped',
  }
  ~> anchor { 'fc_mariadb::columnstore::stop::end': }
}
