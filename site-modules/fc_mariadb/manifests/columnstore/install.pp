# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include fc_mariadb::columnstore::install
class fc_mariadb::columnstore::install {
  class { 'fc_mariadb::packages': }
  ~> package { 'epel-release': }
  ~> package { [ 'glibc-locale-source', 'glibc-langpack-en' ]: }
  ~> exec { 'set character encodings':
    command => '/usr/bin/localedef -i en_US -f UTF-8 en_US.UTF-8',
  }
  ~> package { 'jemalloc': }
  ~> package { [ 'MariaDB-server', 'MariaDB-backup', 'MariaDB-shared', 'MariaDB-client', 'MariaDB-columnstore-engine' ]: }
}
