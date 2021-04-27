# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include fc_admin::repos
class fc_admin::repos {
  $code_dir='/home/cliff/CODE'
  $fc_code_dir="$code_dir/feralcoder"
  $git_password_file='/home/cliff/.git_password'

  exec { "set git usage for cliff":
    command => "/usr/bin/git config --global user.name 'Cliff McIntire' && /usr/bin/git config --global user.email 'feralcoder@gmail.com'",
    user => 'cliff',
    environment => [ 'HOME=/home/cliff' ],
  }

  file { [ "$code_dir", "$fc_code_dir" ]:
    ensure => 'directory',
    mode => '0755',
    owner => 'cliff',
    group => 'cliff',
  }

  exec { 'check out bootstrap-scripts repo':
    creates => "$fc_code_dir/bootstrap-scripts/.git/config",
    command => "/usr/bin/git clone https://feralcoder:`/usr/bin/cat $git_password_file`@github.com/feralcoder/bootstrap-scripts.git $fc_code_dir/bootstrap-scripts"
  }
  exec { 'check out workstation repo':
    creates => "$fc_code_dir/workstation/.git/config",
    command => "/usr/bin/git clone https://feralcoder:`/usr/bin/cat $git_password_file`@github.com/feralcoder/workstation.git $fc_code_dir/workstation"
  }
#  exec { 'check out host_control repo':
#    creates => "$fc_code_dir/host_control/.git/config",
#    command => "/usr/bin/git clone https://feralcoder:`/usr/bin/cat $git_password_file`@github.com/feralcoder/host_control.git $fc_code_dir/host_control"
#  }
  exec { 'check out twilio-pager repo':
    creates => "$fc_code_dir/twilio-pager/.git/config",
    command => "/usr/bin/git clone https://feralcoder:`/usr/bin/cat $git_password_file`@github.com/feralcoder/twilio-pager.git $fc_code_dir/twilio-pager"
  }
#  file { [ "$fc_code_dir/bootstrap-scripts", "$fc_code_dir/workstation", "$fc_code_dir/host_control", "$fc_code_dir/twilio-pager" ]:
  file { [ "$fc_code_dir/bootstrap-scripts", "$fc_code_dir/workstation", "$fc_code_dir/twilio-pager" ]:
    ensure => directory,
    owner => 'cliff',
    group => 'cliff',
    recurse => true,
  }
#  vcsrepo { [ "$fc_code_dir/bootstrap-scripts", "$fc_code_dir/workstation", "$fc_code_dir/host_control", "$fc_code_dir/twilio-pager" ]:
  vcsrepo { [ "$fc_code_dir/bootstrap-scripts", "$fc_code_dir/workstation", "$fc_code_dir/twilio-pager" ]:
    ensure => latest,
    provider => git,
  }
  
  exec { 'bootstrap adminservers as jumphost type':
    command => "$fc_code_dir/bootstrap-scripts/jumphost.sh",
    creates => "/home/cliff/.local_settings",
    user => 'cliff',
    environment => [ 'HOME=/home/cliff' ],
  }
  exec { 'update from workstation script':
    command => "$fc_code_dir/workstation/update.sh",
    user => 'cliff',
    environment => [ 'HOME=/home/cliff' ],
  }



#  git { "$fc_code_dir/workstation":
##    ensure => present,
#    branch => 'master',
#    latest => true,
##    origin => "feralcoder:$git_password@github.com:feralcoder/workstation.git",
#  }
}
