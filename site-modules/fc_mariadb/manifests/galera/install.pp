# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include fc_mariadb::galera::install
class fc_mariadb::galera::install {
  ensure_packages ( [ 'MariaDB-server', 'MariaDB-backup', 'galera-4' ],
    { ensure => present,
        require => Anchor['fc_mariadb::galera::install::late'],
        before => Anchor['fc_mariadb::galera::install::end'],
    }
  )

  anchor { 'fc_mariadb::galera::install::begin': }
  ~> class { 'fc_mariadb::packages': }
  ~> anchor { 'fc_mariadb::galera::install::late': }
  # INSTALL MARIADB COMPONENTS
  ~> anchor { 'fc_mariadb::galera::install::end': }
}
