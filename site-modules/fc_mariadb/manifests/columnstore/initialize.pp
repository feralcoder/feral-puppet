# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include fc_mariadb::columnstore::initialize
class fc_mariadb::columnstore::initialize {
  anchor { 'fc_mariadb::columnstore::initialize::begin': }
  ~> anchor { 'fc_mariadb::columnstore::initialize::end': }
}
