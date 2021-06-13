# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include fc_mariadb::galera
class fc_mariadb::galera {
  exec { 'create fc_mariadb state directory':
    command => "/usr/bin/mkdir -p /etc/puppetlabs/fc_puppet_state"
  }

  # INITIAL BUILD
  if $fc_playlister_oltp_state_fact == 'initial_build'{
    if $fc_playlister_oltp_state_manifest == 'initial_build' {
      exec { 'clear fc_playlister_oltp state before change':
        command => "/usr/bin/rm -f /etc/puppetlabs/fc_puppet_state/fc_playlister_oltp_*",
        notify => Anchor[
                       'fc_common::demandpuppet::begin',
                       'fc_mariadb::cephfs::begin',
                       'fc_mariadb::galera::install::begin',
                       'fc_mariadb::galera::configure::begin'
                   ],
      }
      ~> file { '/etc/puppetlabs/fc_puppet_state/fc_playlister_oltp_initial_build_started':
        ensure => file,
      }
      ~> class { 'fc_common::demandpuppet': }
      ~> class { 'fc_mariadb::cephfs': }
      ~> class { 'fc_mariadb::galera::install': }
      ~> class { 'fc_mariadb::galera::configure': }
      ~> exec { 'clear fc_playlister_oltp state state after change':
        command => "/usr/bin/rm -f /etc/puppetlabs/fc_puppet_state/fc_playlister_oltp_*",
      }
      ~> file { '/etc/puppetlabs/fc_puppet_state/fc_playlister_oltp_initial_build_finished':
        ensure => file,
        require => Anchor[
                       'fc_common::demandpuppet::end',
                       'fc_mariadb::cephfs::end',
                       'fc_mariadb::galera::install::end',
                       'fc_mariadb::galera::configure::end'
                   ],
      }
    } else {
      file { '/tmp/fc_puppet_state.txt':
        content => "Current state is inconsistent"
      }
    }
  }

  # PREINITIALIZE NODE
  if $fc_playlister_oltp_state_fact == 'preinitialize'{
    if $fc_playlister_oltp_state_manifest == 'preinitialize' {
      exec { 'clear fc_playlister_oltp state before change':
        command => "/usr/bin/rm -f /etc/puppetlabs/fc_puppet_state/fc_playlister_oltp_*",
        notify => Anchor[
                       'fc_mariadb::galera::preinitialize::begin',
                   ],
      }
      ~> file { '/etc/puppetlabs/fc_puppet_state/fc_playlister_oltp_preinitialize_started':
        ensure => file,
      }
      ~> class { 'fc_mariadb::galera::preinitialize': }
      ~> exec { 'clear fc_playlister_oltp state state after change':
        command => "/usr/bin/rm -f /etc/puppetlabs/fc_puppet_state/fc_playlister_oltp_*",
      }
      ~> file { '/etc/puppetlabs/fc_puppet_state/fc_playlister_oltp_preinitialize_finished':
        ensure => file,
        require => Anchor[
                       'fc_mariadb::galera::preinitialize::end',
                   ],
      }
    } else {
      file { '/tmp/fc_puppet_state.txt':
        content => "Current state is inconsistent"
      }
    }
  }

  # START FIRST NODE
  if $fc_playlister_oltp_state_fact == 'start_leader_node'{
    if $fc_playlister_oltp_state_manifest == 'start_leader_node' {
      exec { 'clear fc_playlister_oltp state before change':
        command => "/usr/bin/rm -f /etc/puppetlabs/fc_puppet_state/fc_playlister_oltp_*",
        notify => Anchor[
                       'fc_mariadb::galera::start_leader::begin',
                   ],
      }
      ~> file { '/etc/puppetlabs/fc_puppet_state/fc_playlister_oltp_start_leader_node_started':
        ensure => file,
      }
      ~> class { 'fc_mariadb::galera::start_leader': }
      ~> exec { 'clear fc_playlister_oltp state state after change':
        command => "/usr/bin/rm -f /etc/puppetlabs/fc_puppet_state/fc_playlister_oltp_*",
      }
      ~> file { '/etc/puppetlabs/fc_puppet_state/fc_playlister_oltp_start_leader_node_finished':
        ensure => file,
        require => Anchor[
                       'fc_mariadb::galera::start_leader::end',
                   ],
      }
    } else {
      file { '/tmp/fc_puppet_state.txt':
        content => "Current state is inconsistent"
      }
    }
  }

  # JOIN SECONDARY NODE TO CLUSTER
  if $fc_playlister_oltp_state_fact == 'join'{
    if $fc_playlister_oltp_state_manifest == 'join' {
      exec { 'clear fc_playlister_oltp state before change':
        command => "/usr/bin/rm -f /etc/puppetlabs/fc_puppet_state/fc_playlister_oltp_*",
        notify => Anchor[
                       'fc_mariadb::galera::join::begin',
                   ],
      }
      ~> file { '/etc/puppetlabs/fc_puppet_state/fc_playlister_oltp_join_started':
        ensure => file,
      }
      ~> class { 'fc_mariadb::galera::join': }
      ~> exec { 'clear fc_playlister_oltp state state after change':
        command => "/usr/bin/rm -f /etc/puppetlabs/fc_puppet_state/fc_playlister_oltp_*",
      }
      ~> file { '/etc/puppetlabs/fc_puppet_state/fc_playlister_oltp_join_finished':
        ensure => file,
        require => Anchor[
                       'fc_mariadb::galera::join::end',
                   ],
      }
    } else {
      file { '/tmp/fc_puppet_state.txt':
        content => "Current state is inconsistent"
      }
    }
  }

  # STOP NODE
  if $fc_playlister_oltp_state_fact == 'stop'{
    if $fc_playlister_oltp_state_manifest == 'stop' {
      exec { 'clear fc_playlister_oltp state before change':
        command => "/usr/bin/rm -f /etc/puppetlabs/fc_puppet_state/fc_playlister_oltp_*",
        notify => Anchor[
                       'fc_mariadb::galera::stop::begin',
                   ],
      }
      ~> file { '/etc/puppetlabs/fc_puppet_state/fc_playlister_oltp_stop_started':
        ensure => file,
      }
      ~> class { 'fc_mariadb::galera::stop': }
      ~> exec { 'clear fc_playlister_oltp state state after change':
        command => "/usr/bin/rm -f /etc/puppetlabs/fc_puppet_state/fc_playlister_oltp_*",
      }
      ~> file { '/etc/puppetlabs/fc_puppet_state/fc_playlister_oltp_stop_finished':
        ensure => file,
        require => Anchor[
                       'fc_mariadb::galera::stop::end',
                   ],
      }
    } else {
      file { '/tmp/fc_puppet_state.txt':
        content => "Current state is inconsistent"
      }
    }
  }

  # START NODE
  if $fc_playlister_oltp_state_fact == 'start'{
    if $fc_playlister_oltp_state_manifest == 'start' {
      exec { 'clear fc_playlister_oltp state before change':
        command => "/usr/bin/rm -f /etc/puppetlabs/fc_puppet_state/fc_playlister_oltp_*",
        notify => Anchor[
                       'fc_mariadb::galera::start::begin',
                   ],
      }
      ~> file { '/etc/puppetlabs/fc_puppet_state/fc_playlister_oltp_start_started':
        ensure => file,
      }
      ~> class { 'fc_mariadb::galera::start': }
      ~> exec { 'clear fc_playlister_oltp state state after change':
        command => "/usr/bin/rm -f /etc/puppetlabs/fc_puppet_state/fc_playlister_oltp_*",
      }
      ~> file { '/etc/puppetlabs/fc_puppet_state/fc_playlister_oltp_start_finished':
        ensure => file,
        require => Anchor[
                       'fc_mariadb::galera::start::end',
                   ],
      }
    } else {
      file { '/tmp/fc_puppet_state.txt':
        content => "Current state is inconsistent"
      }
    }
  }
}
