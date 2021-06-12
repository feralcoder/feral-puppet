# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include fc_mariadb::columnstore::install
class fc_mariadb::columnstore::install {
  ensure_packages ( 'epel-release',
    { ensure => 'present', }
  )
  ensure_packages ( [ 'glibc-locale-source', 'glibc-langpack-en' ],
    { ensure => 'present', }
  )
  ensure_packages ( 'jemalloc',
    { ensure => 'present', }
  )
  ensure_packages ( [ 'MariaDB-server', 'MariaDB-backup', 'MariaDB-shared', 'MariaDB-client', 'MariaDB-columnstore-engine' ],
    { ensure => 'present', }
  )

  anchor { 'fc_mariadb::columnstore::install::begin': }
  ~> class { 'fc_mariadb::packages': }
  ~> exec { 'set character encodings':
    command => '/usr/bin/localedef -i en_US -f UTF-8 en_US.UTF-8',
  }
  ~> anchor { 'fc_mariadb::columnstore::install::end': }
}
