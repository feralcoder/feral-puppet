# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include fc_mariadb::columnstore
class fc_mariadb::columnstore {
#  class { 'fc_mariadb::columnstore::system': }
#  ~> class { 'fc_mariadb::columnstore::facts': }
  class { 'fc_mariadb::columnstore::install': }
  ~> class { 'fc_mariadb::columnstore::configure': }
}
