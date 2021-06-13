# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include fc_mariadb::columnstore::install
class fc_mariadb::columnstore::install {
  ensure_packages ( 'epel-release',
    { ensure => 'present', 
        require => Anchor['fc_mariadb::columnstore::install::packages1'],
        before => Anchor['fc_mariadb::columnstore::install::packages2'],
    }
  )
  ensure_packages ( [ 'glibc-locale-source', 'glibc-langpack-en' ],
    { ensure => 'present', 
        require => Anchor['fc_mariadb::columnstore::install::packages2'],
        before => Anchor['fc_mariadb::columnstore::install::packages3'],
    }
  )
  ensure_packages ( 'jemalloc',
    { ensure => 'present', 
        require => Anchor['fc_mariadb::columnstore::install::packages3'],
        before => Anchor['fc_mariadb::columnstore::install::packages4'],
    }
  )
  ensure_packages ( [ 'MariaDB-server', 'MariaDB-backup', 'MariaDB-shared', 'MariaDB-client', 'MariaDB-columnstore-engine' ],
    { ensure => 'present', 
        require => Anchor['fc_mariadb::columnstore::install::packages5'],
        before => Anchor['fc_mariadb::columnstore::install::packages6'],
    }
  )


  anchor { 'fc_mariadb::columnstore::install::begin': }
  ~> class { 'fc_mariadb::packages': }
  ~> anchor { 'fc_mariadb::columnstore::install::packages1': }
  # INSTALL EPEL-RELEASE
  ~> anchor { 'fc_mariadb::columnstore::install::packages2': }
  # INSTALL GLIBC
  ~> anchor { 'fc_mariadb::columnstore::install::packages3': }
  # INSTALL JEMALLOC
  ~> anchor { 'fc_mariadb::columnstore::install::packages4': }

  ~> exec { 'set character encodings':
    command => '/usr/bin/localedef -i en_US -f UTF-8 en_US.UTF-8',
  }

  ~> anchor { 'fc_mariadb::columnstore::install::packages5': }
  # INSTALL MARIADB COMPONENTS
  ~> anchor { 'fc_mariadb::columnstore::install::packages6': }
  ~> anchor { 'fc_mariadb::columnstore::install::end': }
}
