# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include fc_playlister_be::cassandra
class fc_playlister_be::cassandra {
  include cassandra::datastax_repo
  include cassandra::java

  class { 'cassandra':
    settings => {
      'authenticator'               => 'PasswordAuthenticator',
      'cluster_name'                => 'PlayLister',
      'commitlog_directory'         => '/var/lib/cassandra/commitlog',
      'commitlog_sync'              => 'periodic',
      'commitlog_sync_period_in_ms' => 10000,
      'data_file_directories'       => ['/var/lib/cassandra/data'],
      'endpoint_snitch'             => 'GossipingPropertyFileSnitch',
      'listen_address'              => $::ipaddress,
      'partitioner'                 => 'org.apache.cassandra.dht.Murmur3Partitioner',
      'saved_caches_directory'      => '/var/lib/cassandra/saved_caches',
      'seed_provider'               => [
        {
          'class_name' => 'org.apache.cassandra.locator.SimpleSeedProvider',
          'parameters' => [
            {
              'seeds' => $cassandra_seeds,
#              'seeds' => $::ipaddress,
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
}
