# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include fc_mariadb::columnstore::configure
class fc_mariadb::columnstore::configure {
  file { '/etc/my.cnf.d/z_playlister-columnstore.cnf':
    ensure => file,
    source => 'puppet:///modules/fc_mariadb/z_playlister-columnstore.cnf',
    mode => '0644',
  }
}


# COLUMNSTORE:
# PLACE: /etc/ceph/key, /etc/ceph/columnstore_share
# SETUP: /columnstore-data/ (mount cephfs)
# SETUP: /columnstore-data/<<CLUSTER_NAME>> (create / find data dir)
