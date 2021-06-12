# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include fc_playlister_be::cassandra
class fc_playlister_be::cassandra {
  ensure_packages ( [ 'python2', 'patch' ],
    { ensure => present, }
  )
  ensure_packages ( [ 'cassandra-driver' ],
    { ensure => present, provider => 'pip2', }
  )

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
  file_line { 'force cqlsh to not use bundled driver':
    path => '/usr/bin/cqlsh',
    match => '.*CQLSH_NO_BUNDLED.*',
    line => "export CQLSH_NO_BUNDLED=TRUE",
    after => "#!/bin/sh",
  }

  file { 'cassandra ownership on /var/lib/cassandra':
    path => '/var/lib/cassandra',
    owner => 'cassandra',
    group => 'cassandra',
  }
  file { '/var/run/cassandra':
    ensure => directory,
    owner => 'cassandra',
    group => 'cassandra',
  }

  # Init scripts not ready for CentOS 8 Systemd
  ~> file { '/etc/rc.d/init.d/cassandra_rc.patch':
    source => "puppet:///modules/fc_playlister_be/cassandra_rc.patch",
  }
  ~> exec { 'patch cassandra init script for systemd / cgroups':
    command => "/usr/bin/cp /etc/rc.d/init.d/cassandra /etc/rc.d/init.d/cassandra.orig && /usr/bin/patch /etc/rc.d/init.d/cassandra /etc/rc.d/init.d/cassandra_rc.patch",
    creates => "/etc/rc.d/init.d/cassandra.orig"
  }
  ~> exec { 'reload systemctl daemon after cassandra init patch':
    command => "/usr/bin/systemctl daemon-reload"
  }


  anchor { 'fc_playlister_be::cassandra::end': }
}
