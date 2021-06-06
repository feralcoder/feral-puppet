# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include fc_playlister_be
class fc_playlister_be {
  exec { 'create fc_playlister_be state directory':
    command => "/usr/bin/mkdir -p /etc/puppetlabs/fc_puppet_state"
  }

  # INITIAL BUILD
  if $fc_playlister_be_state_fact == 'initial_build' {
    if $fc_playlister_be_state_manifest == 'initial_build' {
      exec { 'clear fc_playlister_be state before change':
        command => "/usr/bin/rm -f /etc/puppetlabs/fc_puppet_state/fc_playlister_be_*",
      }
      ~> file { '/etc/puppetlabs/fc_puppet_state/fc_playlister_be_initial_build_started':
        ensure => file,
      }
      ~> class { 'fc_playlister_be::service': }
      ~> class { 'fc_playlister_be::cassandra': }
      ~> exec { 'clear fc_playlister_be state after change':
        command => "/usr/bin/rm -f /etc/puppetlabs/fc_puppet_state/fc_playlister_be_*",
      }
      ~> file { '/etc/puppetlabs/fc_puppet_state/fc_playlister_be_initial_build_finished':
        ensure => file,
        require => Anchor['fc_playlister_be::cassandra::end'],
      }
    } else {
      file { '/tmp/fc_puppet_state.txt':
        content => "Current state is inconsistent"
      }
    }
  }



  # STARTING
  if $fc_playlister_be_state_fact == 'starting' {
    if $fc_playlister_be_state_manifest == 'starting' {
      exec { 'clear fc_playlister_be state before change':
        command => "/usr/bin/rm -f /etc/puppetlabs/fc_puppet_state/fc_playlister_be_*",
      }
      ~> file { '/etc/puppetlabs/fc_puppet_state/fc_playlister_be_starting_started':
        ensure => file,
      }
      ~> class { 'fc_playlister_be::cassandra_start': }
      ~> exec { 'clear fc_playlister_be state after change':
        command => "/usr/bin/rm -f /etc/puppetlabs/fc_puppet_state/fc_playlister_be_*",
      }
      ~> file { '/etc/puppetlabs/fc_puppet_state/fc_playlister_be_starting_finished':
        ensure => file,
        require => Anchor['fc_playlister_be::cassandra_start::end'],
      }
    } else {
      file { '/tmp/fc_puppet_state.txt':
        content => "Current state is inconsistent"
      }
    }
  }



  # LOAD_SCHEMA
  if $fc_playlister_be_state_fact == 'load_schema' {
    if $fc_playlister_be_state_manifest == 'load_schema' {
      exec { 'clear fc_playlister_be state before change':
        command => "/usr/bin/rm -f /etc/puppetlabs/fc_puppet_state/fc_playlister_be_*",
      }
      ~> file { '/etc/puppetlabs/fc_puppet_state/fc_playlister_be_load_schema_started':
        ensure => file,
      }
      ~> class { 'fc_playlister_be::cassandra': }
      ~> class { 'fc_playlister_be::cassandra_schema': }
      ~> exec { 'clear fc_playlister_be state after change':
        command => "/usr/bin/rm -f /etc/puppetlabs/fc_puppet_state/fc_playlister_be_*",
      }
      ~> file { '/etc/puppetlabs/fc_puppet_state/fc_playlister_be_load_schema_finished':
        ensure => file,
        require => Anchor['fc_playlister_be::cassandra::end', 'fc_playlister_be::cassandra_schema::end'],
      }
    } else {
      file { '/tmp/fc_puppet_state.txt':
        content => "Current state is inconsistent"
      }
    }
  }



  # STARTED
  if $fc_playlister_be_state_fact == 'started' {
    if $fc_playlister_be_state_manifest == 'started' {
      exec { 'clear fc_playlister_be state before change':
        command => "/usr/bin/rm -f /etc/puppetlabs/fc_puppet_state/fc_playlister_be_*",
      }
      ~> file { '/etc/puppetlabs/fc_puppet_state/fc_playlister_be_started_started':
        ensure => file,
      }
      ~> class { 'fc_playlister_be::cassandra_started': }
      ~> exec { 'clear fc_playlister_be state after change':
        command => "/usr/bin/rm -f /etc/puppetlabs/fc_puppet_state/fc_playlister_be_*",
      }
      ~> file { '/etc/puppetlabs/fc_puppet_state/fc_playlister_be_started_finished':
        ensure => file,
        require => Anchor['fc_playlister_be::cassandra_started::end'],
      }
    } else {
      file { '/tmp/fc_puppet_state.txt':
        content => "Current state is inconsistent"
      }
    }
  }



  # NOMINAL
  if $fc_playlister_be_state_fact == 'nominal' {
    if $fc_playlister_be_state_manifest == 'nominal' {
      exec { 'clear fc_playlister_be state before change':
        command => "/usr/bin/rm -f /etc/puppetlabs/fc_puppet_state/fc_playlister_be_*",
      }
      ~> file { '/etc/puppetlabs/fc_puppet_state/fc_playlister_be_nominal_started':
        ensure => file,
      }
      ~> class { 'fc_playlister_be::cassandra_started': }
      ~> exec { 'clear fc_playlister_be state after change':
        command => "/usr/bin/rm -f /etc/puppetlabs/fc_puppet_state/fc_playlister_be_*",
      }
      ~> file { '/etc/puppetlabs/fc_puppet_state/fc_playlister_be_nominal_finished':
        ensure => file,
        require => Anchor['fc_playlister_be::cassandra_started::end'],
      }
    } else {
      file { '/tmp/fc_puppet_state.txt':
        content => "Current state is inconsistent"
      }
    }
  }



  # STOPPING
  if $fc_playlister_be_state_fact == 'stopping' {
    if $fc_playlister_be_state_manifest == 'stopping' {
      exec { 'clear fc_playlister_be state before change':
        command => "/usr/bin/rm -f /etc/puppetlabs/fc_puppet_state/fc_playlister_be_*",
      }
      ~> file { '/etc/puppetlabs/fc_puppet_state/fc_playlister_be_stopping_started':
        ensure => file,
      }
      ~> class { 'fc_playlister_be::cassandra_stop': }
      ~> exec { 'clear fc_playlister_be state after change':
        command => "/usr/bin/rm -f /etc/puppetlabs/fc_puppet_state/fc_playlister_be_*",
      }
      ~> file { '/etc/puppetlabs/fc_puppet_state/fc_playlister_be_stopping_finished':
        ensure => file,
        require => Anchor['fc_playlister_be::cassandra_stop::end'],
      }
    } else {
      file { '/tmp/fc_puppet_state.txt':
        content => "Current state is inconsistent"
      }
    }
  }



  # STOPPED
  if $fc_playlister_be_state_fact == 'stopped' {
    if $fc_playlister_be_state_manifest == 'stopped' {
      exec { 'clear fc_playlister_be state before change':
        command => "/usr/bin/rm -f /etc/puppetlabs/fc_puppet_state/fc_playlister_be_*",
      }
      ~> file { '/etc/puppetlabs/fc_puppet_state/fc_playlister_be_stopped_started':
        ensure => file,
      }
      ~> class { 'fc_playlister_be::cassandra_stopped': }
      ~> exec { 'clear fc_playlister_be state after change':
        command => "/usr/bin/rm -f /etc/puppetlabs/fc_puppet_state/fc_playlister_be_*",
      }
      ~> file { '/etc/puppetlabs/fc_puppet_state/fc_playlister_be_stopped_finished':
        ensure => file,
        require => Anchor['fc_playlister_be::cassandra_stopped::end'],
      }
    } else {
      file { '/tmp/fc_puppet_state.txt':
        content => "Current state is inconsistent"
      }
    }
  }
}
