# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include fc_playlister_be
class fc_playlister_be {

  if $playlister_cassandra_delayed_install == false {
    class { 'fc_playlister_be::cassandra': }
    file { '/tmp/cassandra.txt':
      content => "$cassandra"
    }
    file { '/tmp/cassandra_package_name.txt':
      content => "$cassandra::package_name"
    }
    file { '/tmp/cassandra_install':
      content => "true"
    }
  } else {
    file { '/tmp/cassandra_test':
      content => "delayed"
    }
    file { '/tmp/cassandra_install':
      content => "delayed"
    }
  }
}
