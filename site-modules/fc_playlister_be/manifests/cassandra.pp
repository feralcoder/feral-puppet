# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include fc_playlister_be::cassandra
class fc_playlister_be::cassandra {

  class { 'cassandra::datastax_repo':
    before => Class['cassandra']
  }

  class { 'cassandra::java':
    before => Class['cassandra']
  }

  class { 'cassandra':
    dc             => "$cassandra::dc",
    settings       => {
      'authenticator'               => 'PasswordAuthenticator',
      'authorizer'                  => 'CassandraAuthorizer',
#      'authenticator'               => 'AllowAllAuthenticator',
      'auto_bootstrap'              => false,
      'cluster_name'                => "$cassandra::settings::cluster_name",
      'commitlog_directory'         => '/var/lib/cassandra/commitlog',
      'commitlog_sync'              => 'periodic',
      'commitlog_sync_period_in_ms' => 10000,
      'data_file_directories'       => ['/var/lib/cassandra/data'],
      'endpoint_snitch'             => 'GossipingPropertyFileSnitch',
      'hints_directory'             => '/var/lib/cassandra/hints',
      'listen_interface'            => 'eth0',
      'num_tokens'                  => 256,
      'partitioner'                 => 'org.apache.cassandra.dht.Murmur3Partitioner',
      'saved_caches_directory'      => '/var/lib/cassandra/saved_caches',
      'seed_provider'               => [
        {
          'class_name' => 'org.apache.cassandra.locator.SimpleSeedProvider',
          'parameters' => [
            {
              'seeds' => "$cassandra_seeds",
            },
          ],
        },
      ],
      'start_native_transport'      => true,
      # HINTS config for Cass 3.X
      'hints_directory'             => '/var/lib/cassandra/hints',
    },
    require  => Class['cassandra::datastax_repo', 'cassandra::java'],
  }

  file { '/var/lib/cassandra/.cassandra':
    ensure => directory,
    owner => 'cassandra',
    group => 'cassandra',
  }

  # cqlsh errors fixed with:
  # https://issues.apache.org/jira/browse/CASSANDRA-11573
  file { 'remove copyutil.so':
    path => '/usr/lib/python2.7/site-packages/cqlshlib/copyutil.so',
    ensure => absent
  }
  file { 'remove copyutil.pyc':
    path => '/usr/lib/python2.7/site-packages/cqlshlib/copyutil.pyc',
    ensure => absent
  }
  # https://issues.apache.org/jira/browse/CASSANDRA-11850
  ~> package { 'python2': }
  ~> package { 'cassandra-driver': 
    provider => pip2,
  }
  file { 'cassandra ownership on /var/lib/cassandra':
    path => '/var/lib/cassandra',
    owner => 'cassandra',
    group => 'cassandra',
  }


#  exec { 'create .bashrc for cassandra user':
#    command => '/usr/bin/touch /var/lib/cassandra/.bashrc',
#    user => 'cassandra'
#  }
#  exec { 'create .bash_profile for cassandra user':
#    command => '/usr/bin/touch /var/lib/cassandra/.bash_profile',
#    user => 'cassandra'
#  }
#  ~> file_line { 'set cqlsh driver fix in cassandra user envs in .bashrc':
#    path => '/var/lib/cassandra/.bashrc',
#    match => '.*CQLSH_NO_BUNDLED.*',
#    line => "export CQLSH_NO_BUNDLED=TRUE",
#  }
#  ~> file_line { 'set cqlsh driver fix in cassandra user envs in .bash_profile':
#    path => '/var/lib/cassandra/.bash_profile',
#    match => '.*CQLSH_NO_BUNDLED.*',
#    line => "export CQLSH_NO_BUNDLED=TRUE",
#  }
#    
#  ~> file_line { 'set cqlsh driver fix in cliff user envs in .bashrc':
#    path => '/home/cliff/.bashrc',
#    match => '.*CQLSH_NO_BUNDLED.*',
#    line => "export CQLSH_NO_BUNDLED=TRUE",
#  }
#  ~> file_line { 'set cqlsh driver fix in cliff user envs in .bash_profile':
#    path => '/home/cliff/.bash_profile',
#    match => '.*CQLSH_NO_BUNDLED.*',
#    line => "export CQLSH_NO_BUNDLED=TRUE",
#  }
#    
#  ~> file_line { 'set cqlsh driver fix in root user envs in .bashrc':
#    path => '/root/.bashrc',
#    match => '.*CQLSH_NO_BUNDLED.*',
#    line => "export CQLSH_NO_BUNDLED=TRUE",
#  }
#  ~> file_line { 'set cqlsh driver fix in root user envs in .bash_profile':
#    path => '/root/.bash_profile',
#    match => '.*CQLSH_NO_BUNDLED.*',
#    line => "export CQLSH_NO_BUNDLED=TRUE",
#  }
    
  anchor { 'fc_playlister_be::cassandra::end': }
}
