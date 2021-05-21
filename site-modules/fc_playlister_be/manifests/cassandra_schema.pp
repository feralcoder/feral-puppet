# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include fc_playlister_be::cassandra_schema
class fc_playlister_be::cassandra_schema {

  class { 'cassandra::schema':
    before => Anchor['fc_playlister_be::cassandra_schema::end'],
    cqlsh_password => 'cassandra',
    cqlsh_user     => 'cassandra',
    cqlsh_host     => $::ipaddress,
    indexes        => {
      'users_lname_idx' => {
        table    => 'users',
        keys     => 'lname',
        keyspace => 'playlister_keyspace',
      },
    },
    keyspaces      => {
      'playlister_keyspace' => {
        durable_writes  => false,
        replication_map => {
          keyspace_class     => 'SimpleStrategy',
          replication_factor => 2,
        },
      }
    },
    permissions    => {
      'Grant select permissions to playlister_user to all keyspaces' => {
        permission_name => 'SELECT',
        user_name       => 'playlister_user',
      },
      'Grant modify to to keyspace playlister_keyspace to playlister_deploy'       => {
        keyspace_name   => 'playlister_keyspace',
        permission_name => 'MODIFY',
        user_name       => 'playlister_deploy',
      },
      'Grant alter permissions to playlister_keyspace to playlister_admin'        => {
        keyspace_name   => 'playlister_keyspace',
        permission_name => 'ALTER',
        user_name       => 'playlister_admin',
      },
      'Grant ALL permissions to playlister_keyspace.users to user_admin'  => {
        keyspace_name   => 'playlister_keyspace',
        permission_name => 'ALTER',
        table_name      => 'users',
        user_name       => 'user_admin',
      },
    },
    tables         => {
#      # ENFORCE UNAME UNIQUENESS
#      'unames' => {
#        columns  => {
#          uname         => 'text',
#          user_id       => 'int',
#          'PRIMARY KEY' => '(uname)',
#        },
#        keyspace => 'playlister_keyspace',
#      },
      'users' => {
        columns  => {
          user_id       => 'int',
          uname         => 'text',
          fname         => 'text',
          lname         => 'text',
          'PRIMARY KEY' => '(user_id)',
        },
        keyspace => 'playlister_keyspace',
      },
      'songs' => {
        columns  => {
          song_id       => 'int',
          name          => 'text',
          artist        => 'text',
          meta          => 'text',
          location      => 'text',
          collection    => 'text',
          'PRIMARY KEY' => '(song_id)',
        },
        keyspace => 'playlister_keyspace',
      },
      'user_songs' => {
        columns  => {
          usong_id      => 'int',
          song_id       => 'int',
          rating        => 'float',
          meta          => 'text',
          'PRIMARY KEY' => '(usong_id)',
        },
        keyspace => 'playlister_keyspace',
      },
      'static_list_meta' => {
        columns  => {
          statlist_id   => 'int',
          name          => 'text',
          owner_id      => 'int',
          meta          => 'text',
          'PRIMARY KEY' => '(statlist_id)',
        },
        keyspace => 'playlister_keyspace',
      },
      'static_list' => {
        columns  => {
          statlist_id   => 'int',
          seq           => 'float',
          song_id       => 'int',
          'PRIMARY KEY' => '(statlist_id)',
        },
        keyspace => 'playlister_keyspace',
      },
      'dynamic_list_meta' => {
        columns => {
          dynlist_id    => 'int',
          name          => 'text',
          owner_id      => 'int',
          meta          => 'text',
          'PRIMARY KEY' => '(dynlist_id)',
        },
        keyspace => 'playlister_keyspace',
      },
      'dynamic_list_node' => {
        columns  => {
          dynlist_id    => 'int',
          plist_id      => 'int',
          t1_type       => 'int',
          t1_target     => 'int',
          t2_target     => 'int',
          'PRIMARY KEY' => '(dynlist_id)',
        },
        keyspace => 'playlister_keyspace',
      },
    },
    users          => {
      'playlister_user' => {
        password => 'playlister_user',
      },
      'playlister_deploy'    => {
        password  => 'playlister_deploy',
        superuser => true,
      },
      'playlister_admin'    => {
        password => 'playlister_admin',
      },
      'user_admin'  => {
        'password' => 'user_admin',
      },
    },
  }
  anchor { 'fc_playlister_be::cassandra_schema::end': }
}
