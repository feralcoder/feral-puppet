# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include fc_playlister_be::cassandra_start
class fc_playlister_be::cassandra_start {
  service { 'start cassandra':
    name => 'cassandra',
    ensure => 'running',
  }
  anchor { 'fc_playlister_be::cassandra_start::end': }
}
