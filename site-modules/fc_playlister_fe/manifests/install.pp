# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include fc_playlister_fe::install
class fc_playlister_fe::install {
  ensure_packages ( [ 'python3', 'haproxy' ],
    { ensure => present,
        require => Anchor['fc_mariadb::cephfs::begin'],
        before => Anchor['fc_mariadb::cephfs::packages1'],
        before => Anchor['fc_mariadb::cephfs::end'],
    }
  )
  ensure_packages ( [ 'cassandra-driver' ],
    { ensure => present, provider => 'pip3',
        require => Anchor['fc_mariadb::cephfs::begin'],
        before => Anchor['fc_mariadb::cephfs::packages1'],
        before => Anchor['fc_mariadb::cephfs::end'],
    }
  )

  anchor { 'fc_playlister_fe::install::begin': }
  ~> anchor { 'fc_playlister_fe::install::end': }
}
