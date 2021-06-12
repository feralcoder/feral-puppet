# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include fc_mariadb::columnstore
class fc_mariadb::columnstore {
  exec { 'create fc_mariadb state directory':
    command => "/usr/bin/mkdir -p /etc/puppetlabs/fc_puppet_state"
  }

  # INITIAL BUILD
  if $fc_playlister_olap_state_fact == 'initial_build'{
    if $fc_playlister_olap_state_manifest == 'initial_build' {
      exec { 'clear fc_playlister_olap state before change':
        command => "/usr/bin/rm -f /etc/puppetlabs/fc_puppet_state/fc_playlister_olap_*",
        notify => Anchor[
                       'fc_common::demandpuppet::begin',
                       'fc_mariadb::cephfs::begin',
                       'fc_mariadb::columnstore::install::begin',
                       'fc_mariadb::columnstore::configure::begin'
                   ],
      }
      ~> file { '/etc/puppetlabs/fc_puppet_state/fc_playlister_olap_initial_build_started':
        ensure => file,
      }
      ~> class { 'fc_common::demandpuppet': }
      ~> class { 'fc_mariadb::cephfs': }
      ~> class { 'fc_mariadb::columnstore::install': }
      ~> class { 'fc_mariadb::columnstore::configure': }
      ~> exec { 'clear fc_playlister_olap state state after change':
        command => "/usr/bin/rm -f /etc/puppetlabs/fc_puppet_state/fc_playlister_olap_*",
      }
      ~> file { '/etc/puppetlabs/fc_puppet_state/fc_playlister_olap_initial_build_finished':
        ensure => file,
        require => Anchor[
                       'fc_common::demandpuppet::begin',
                       'fc_mariadb::cephfs::end',
                       'fc_mariadb::columnstore::install::end',
                       'fc_mariadb::columnstore::configure::end'
                   ],
      }
    } else {
      file { '/tmp/fc_puppet_state.txt':
        content => "Current state is inconsistent"
      }
    }
  }

  # INITIALIZE FIRST NODE
  if $fc_playlister_olap_state_fact == 'initialize_first_node'{
    if $fc_playlister_olap_state_manifest == 'initialize_first_node' {
      exec { 'clear fc_playlister_olap state before change':
        command => "/usr/bin/rm -f /etc/puppetlabs/fc_puppet_state/fc_playlister_olap_*",
        notify => Anchor[
                       'fc_mariadb::columnstore::initialize::begin',
                   ],
      }
      ~> file { '/etc/puppetlabs/fc_puppet_state/fc_playlister_olap_initial_build_started':
        ensure => file,
      }
      ~> class { 'fc_mariadb::columnstore::initialize': }
      ~> exec { 'clear fc_playlister_olap state state after change':
        command => "/usr/bin/rm -f /etc/puppetlabs/fc_puppet_state/fc_playlister_olap_*",
      }
      ~> file { '/etc/puppetlabs/fc_puppet_state/fc_playlister_olap_initialize_finished':
        ensure => file,
        require => Anchor[
                       'fc_mariadb::columnstore::initialize::end',
                   ],
      }
    } else {
      file { '/tmp/fc_puppet_state.txt':
        content => "Current state is inconsistent"
      }
    }
  }
}
