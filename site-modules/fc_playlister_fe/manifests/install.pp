# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include fc_playlister_fe::install
class fc_playlister_fe::install {
  ensure_packages ( [ 'python3', 'haproxy' ],
    { ensure => present, }
  )
  ensure_packages ( [ 'cassandra-driver' ],
    { ensure => present, provider => 'pip3', }
  )
}
