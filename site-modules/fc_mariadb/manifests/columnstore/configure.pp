# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include fc_mariadb::columnstore::configure
class fc_mariadb::columnstore::configure {
  anchor { 'fc_mariadb::columnstore::configure::begin': }
  ~> file { "/local-data":
    ensure => directory,
    owner => 'mysql',
    group => 'mysql',
  }
  ~> file { [ "/local-data/$fc_playlister_olap::cluster_name", "/local-data/$fc_playlister_olap::cluster_name/columnstore", "/local-data/$fc_playlister_olap::cluster_name/columnstore/$clientcert", "/local-data/$fc_playlister_olap::cluster_name/columnstore/$clientcert/storagemanager" ]:
    ensure => directory,
    owner => 'mysql',
    group => 'mysql',
  }
  ~> file { [ "/cephfs-data/$fc_playlister_olap::cluster_name", "/cephfs-data/$fc_playlister_olap::cluster_name/columnstore", "/cephfs-data/$fc_playlister_olap::cluster_name/columnstore/$clientcert", "/cephfs-data/$fc_playlister_olap::cluster_name/columnstore/$clientcert/storagemanager" ]:
    ensure => directory,
    owner => 'mysql',
    group => 'mysql',
  }
  ~> file { '/etc/columnstore/z_playlister-storagemanager.cnf':
    ensure => file,
    content => template('fc_mariadb/z_playlister-storagemanager.cnf'),
    mode => '0644',
  }
  ~> file { '/etc/my.cnf.d/z_playlister-columnstore.cnf':
    ensure => file,
    content => template('fc_mariadb/z_playlister-columnstore.cnf'),
    mode => '0644',
  }
  ~> anchor { 'fc_mariadb::columnstore::configure::end': }
}
