# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include fc_mariadb::galera::configure
class fc_mariadb::galera::configure {
  file { '/etc/my.cnf.d/z_playlister-galera.cnf':
    ensure => file,
    source => 'puppet:///modules/fc_mariadb/z_playlister-galera.cnf',
    mode => '0644',
  }
}

# PLACE: /etc/my.cnf.d/z_playlister.cnf
# REPLACE: <<CLUSTER_LIST>>,<<CLUSTER_NAME>>

# SET UP DIR: datadir=/galera-data/<<CLUSTER_NAME>>

# ORCHESTRATE: 
#   INIT: After first setup, run galera_new_cluster on one, then start others.
#   STOP / START: Ordered
