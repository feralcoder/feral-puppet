# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include fc_mariadb::packages
class fc_mariadb::packages {
  package { 'wget': }
  ~> exec { 'fetch mariadb yum repo installer':
     command => '/usr/bin/wget https://downloads.mariadb.com/MariaDB/mariadb_repo_setup -O /tmp/mariadb_repo_setup',
  }
  ~> exec { 'check mariadb_repo_setup checksum':
     command => '/usr/bin/echo "417ea3052a78a11f022c596e29360cd0568161e0ffb17067589421883c34bc99 /tmp/mariadb_repo_setup" | /usr/bin/sha256sum -c -',
  }
  ~> file { 'set execute on mariadb_repo_setup':
     path => '/tmp/mariadb_repo_setup',
     mode => 'a+x',
  }
  ~> exec { 'install mariadb yum repos':
     command => '/tmp/mariadb_repo_setup --mariadb-server-version="mariadb-10.5"',
  }
}
