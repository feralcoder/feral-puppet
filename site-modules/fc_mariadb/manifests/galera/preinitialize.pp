# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include fc_mariadb::galera::preinitialize
class fc_mariadb::galera::preinitialize {
  anchor { 'fc_mariadb::galera::preinitialize::begin': }
  ~> service { 'stop mariadb for preinitialization':
    name => 'mariadb',
    ensure => 'stopped',
  }
  ~> exec { 'delete files to preinitialize Galera':
    command => "/usr/bin/rm -f /cephfs-data/$fc_playlister_oltp::cluster_name/galera/$clientcert/grastate.dat /cephfs-data/$fc_playlister_oltp::cluster_name/galera/$clientcert/ib_logfile*",
  }
  ~> anchor { 'fc_mariadb::galera::preinitialize::end': }
}
