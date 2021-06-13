# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include fc_playlister_fe::install
class fc_playlister_fe::install {
  if !defined(Package['python3']) {
    ensure_packages ( 'python3',
    { ensure => present,
        require => Anchor['fc_playlister_fe::install::packages1'],
        before => Anchor['fc_playlister_fe::install::packages2'],
    }
  )}
  if !defined(Package['haproxy']) {
    ensure_packages ( 'haproxy',
    { ensure => present,
        require => Anchor['fc_playlister_fe::install::packages1'],
        before => Anchor['fc_playlister_fe::install::packages2'],
    }
  )}
  if !defined(Package['cassandra-driver']) {
    ensure_packages ( [ 'cassandra-driver' ],
    { ensure => present, provider => 'pip3',
        require => Anchor['fc_playlister_fe::install::packages2'],
        before => Anchor['fc_playlister_fe::install::packages3'],
    }
  )}

  anchor { 'fc_playlister_fe::install::begin': }
  ~> anchor { 'fc_playlister_fe::install::packages1': }
  INSTALL PYTHON, HAPROXY
  ~> anchor { 'fc_playlister_fe::install::packages2': }
  INSTALL PIP
  ~> anchor { 'fc_playlister_fe::install::packages3': }
  ~> anchor { 'fc_playlister_fe::install::end': }
}
