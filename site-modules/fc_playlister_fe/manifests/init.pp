# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include fc_playlister_fe
class fc_playlister_fe {
  exec { 'create fc_playlister_fe state directory':
    command => "/usr/bin/mkdir -p /etc/puppetlabs/fc_puppet_state"
  }

  # INITIAL BUILD
  if $fc_playlister_fe_state_fact == 'initial_build'{
    if $fc_playlister_fe_state_manifest == 'initial_build' {
      exec { 'clear fc_playlister_fe state before change':
        command => "/usr/bin/rm -f /etc/puppetlabs/fc_puppet_state/fc_playlister_fe_*",
        notify => Anchor[
                       'fc_common::demandpuppet::begin',
                       'fc_playlister_fe::install::begin',
                       'fc_playlister_fe::configure::begin',
                       'fc_playlister_fe::service::begin',
                   ],
      }
      ~> file { '/etc/puppetlabs/fc_puppet_state/fc_playlister_fe_initial_build_started':
        ensure => file,
      }
      ~> class { 'fc_common::demandpuppet': }
      ~> class { 'fc_playlister_fe::install': }
      ~> class { 'fc_playlister_fe::configure': }
      ~> class { 'fc_playlister_fe::service': }
      ~> exec { 'clear fc_playlister_fe state state after change':
        command => "/usr/bin/rm -f /etc/puppetlabs/fc_puppet_state/fc_playlister_fe_*",
      }
      ~> file { '/etc/puppetlabs/fc_puppet_state/fc_playlister_fe_initial_build_finished':
        ensure => file,
        require => Anchor[
                       'fc_common::demandpuppet::end',
                       'fc_playlister_fe::install::end',
                       'fc_playlister_fe::configure::end',
                       'fc_playlister_fe::service::end',
                   ],
      }
    } else {
      file { '/tmp/fc_puppet_state.txt':
        content => "Current state is inconsistent"
      }
    }
  }

  # DEPLOY CODE
  if $fc_playlister_fe_state_fact == 'deploy'{
    if $fc_playlister_fe_state_manifest == 'deploy' {
      exec { 'clear fc_playlister_fe state before change':
        command => "/usr/bin/rm -f /etc/puppetlabs/fc_puppet_state/fc_playlister_fe_*",
        notify => Anchor[
                       'fc_playlister_fe::deploy::begin',
                   ],
      }
      ~> file { '/etc/puppetlabs/fc_puppet_state/fc_playlister_fe_deploy_started':
        ensure => file,
      }
      ~> class { 'fc_playlister_fe::deploy': }
      ~> exec { 'clear fc_playlister_fe state state after change':
        command => "/usr/bin/rm -f /etc/puppetlabs/fc_puppet_state/fc_playlister_fe_*",
      }
      ~> file { '/etc/puppetlabs/fc_puppet_state/fc_playlister_fe_deploy_finished':
        ensure => file,
        require => Anchor[
                       'fc_playlister_fe::deploy::end',
                   ],
      }
    } else {
      file { '/tmp/fc_puppet_state.txt':
        content => "Current state is inconsistent"
      }
    }
  }
}
