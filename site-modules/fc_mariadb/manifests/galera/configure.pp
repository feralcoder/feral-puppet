# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include fc_mariadb::galera::configure
class fc_mariadb::galera::configure {
  anchor { 'fc_mariadb::galera::configure::begin': }
  ~> file { [ "/local-data", "/local-data/$fc_playlister_oltp::cluster_name", "/local-data/$fc_playlister_oltp::cluster_name/galera", "/local-data/$fc_playlister_oltp::cluster_name/galera/$clientcert" ]:
    ensure => directory,
    owner => 'mysql',
    group => 'mysql',
  }
  ~> file { [ "/cephfs-data/$fc_playlister_oltp::cluster_name", "/cephfs-data/$fc_playlister_oltp::cluster_name/galera", "/cephfs-data/$fc_playlister_oltp::cluster_name/galera/$clientcert" ]:
    ensure => directory,
    owner => 'mysql',
    group => 'mysql',
  }
  ~> file { '/etc/my.cnf.d/z_playlister-galera.cnf':
    ensure => file,
    content => template('fc_mariadb/z_playlister-galera.cnf'),
    #source => 'puppet:///modules/fc_mariadb/z_playlister-galera.cnf',
    mode => '0644',
  }
  ~> anchor { 'fc_mariadb::galera::configure::end': }
}
