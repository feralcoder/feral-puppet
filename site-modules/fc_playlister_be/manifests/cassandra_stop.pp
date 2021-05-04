# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include fc_playlister_be::cassandra_stop
class fc_playlister_be::cassandra_stop {
  service { 'stop cassandra':
    name => 'cassandra',
    ensure => 'stopped',
  }
  anchor { 'fc_playlister_be::cassandra_stop::end': }
}
