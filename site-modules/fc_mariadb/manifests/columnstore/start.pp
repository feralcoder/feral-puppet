# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include fc_mariadb::columnstore::start
class fc_mariadb::columnstore::start {
  anchor { 'fc_mariadb::columnstore::start::begin': }
  ~> service { 'start columnstore node':
    name => 'mariadb',
    ensure => 'running',
  }
  ~> anchor { 'fc_mariadb::columnstore::start::end': }
}
