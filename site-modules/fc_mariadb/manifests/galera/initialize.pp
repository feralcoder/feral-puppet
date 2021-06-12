# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include fc_mariadb::galera::initialize
class fc_mariadb::galera::initialize {
  anchor { 'fc_mariadb::galera::initialize::begin': }
  ~> exec { 'create DB for galera':
    command => "/usr/bin/mysql_install_db --user=mysql --ldata=/cephfs-data/$fc_playlister_oltp::cluster_name/galera/$clientcert"
  }
  ~> file_line { 'hose wsrep cluster for initialization':
    path => '/etc/my.cnf.d/z_playlister-galera.cnf',
    line => 'wsrep_cluster_address=gcomm://',
    after => 'wsrep_cluster_address=gcomm://[0-9]+'
  }
  ~> exec { 'initialize Galera':
    command => "/usr/bin/galera_new_cluster",
  }
  ~> file_line { 'restore wsrep cluster post initialization':
    path => '/etc/my.cnf.d/z_playlister-galera.cnf',
    ensure => 'absent',
    match_for_absence => 'true',
    match => '^wsrep_cluster_address=gcomm://$',
  }
  ~> anchor { 'fc_mariadb::galera::initialize::end': }
}


# 
# Installing MariaDB/MySQL system tables in '/test-db/' ...
# OK
# 
# To start mysqld at boot time you have to copy
# support-files/mysql.server to the right place for your system
# 
# 
# Two all-privilege accounts were created.
# One is root@localhost, it has no password, but you need to
# be system 'root' user to connect. Use, for example, sudo mysql
# The second is mysql@localhost, it has no password either, but
# you need to be the system 'mysql' user to connect.
# After connecting you can set the password, if you would need to be
# able to connect as any of these users with a password and without sudo
# 
# See the MariaDB Knowledgebase at https://mariadb.com/kb or the
# MySQL manual for more instructions.
# 
# You can start the MariaDB daemon with:
# cd '/usr' ; /usr/bin/mysqld_safe --datadir='/test-db/'
# 
# You can test the MariaDB daemon with mysql-test-run.pl
# cd '/usr/mysql-test' ; perl mysql-test-run.pl
# 
# Please report any problems at https://mariadb.org/jira
# 
# The latest information about MariaDB is available at https://mariadb.org/.
# You can find additional information about the MySQL part at:
# https://dev.mysql.com
# Consider joining MariaDB's strong and vibrant community:
# https://mariadb.org/get-involved/
# 
# 
