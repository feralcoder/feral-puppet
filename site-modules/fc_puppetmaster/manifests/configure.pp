# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include fc_puppetmaster::configure
class fc_puppetmaster::configure {
  $puppet_code_dir='/etc/puppetlabs/code/environments'
  $git_password_file='/home/cliff/.git_password'
  $root_code_dir='/root/CODE'
  $fc_code_dir="$root_code_dir/feralcoder"

  exec { "set git usage for puppetmaster":
    command => "/usr/bin/git config --global user.name 'Cliff McIntire' && /usr/bin/git config --global user.email 'feralcoder@gmail.com'",
    user => 'root',
    environment => [ 'HOME=/root/' ],
  }

  # This is a chicken-egg situation: needs external setup, and thus will never run if self-bootstrapped
  exec { 'check out puppetmaster configs':
    creates => "$puppet_code_dir/production/.git/config",
    command => "/usr/bin/git clone https://feralcoder:`/usr/bin/cat $git_password_file`@github.com/feralcoder/feral-puppet.git $puppet_code_dir/production && cd $puppet_code_dir/production && git checkout production"
  }
  vcsrepo { "$puppet_code_dir/production":
    ensure => latest,
    provider => git,
  }
  

  # ROOT GETS FERALCODER SETUP, for CLI / ENV tools to manage puppet configs, alerts, etc...
  file { [ "$root_code_dir", "$fc_code_dir" ]:
    ensure => 'directory',
    mode => '0755',
    owner => 'root',
    group => 'root',
  }
  exec { 'check out bootstrap-scripts repo':
    creates => "$fc_code_dir/bootstrap-scripts/.git/config",
    command => "/usr/bin/git clone https://feralcoder:`/usr/bin/cat $git_password_file`@github.com/feralcoder/bootstrap-scripts.git $fc_code_dir/bootstrap-scripts"
  }
  exec { 'check out workstation repo':
    creates => "$fc_code_dir/workstation/.git/config",
    command => "/usr/bin/git clone https://feralcoder:`/usr/bin/cat $git_password_file`@github.com/feralcoder/workstation.git $fc_code_dir/workstation"
  }
  exec { 'check out twilio-pager repo':
    creates => "$fc_code_dir/twilio-pager/.git/config",
    command => "/usr/bin/git clone https://feralcoder:`/usr/bin/cat $git_password_file`@github.com/feralcoder/twilio-pager.git $fc_code_dir/twilio-pager"
  }
  file { [ "$fc_code_dir/bootstrap-scripts", "$fc_code_dir/workstation", "$fc_code_dir/twilio-pager" ]:
    ensure => directory,
    owner => 'root',
    group => 'root',
    recurse => true,
  }
  vcsrepo { [ "$fc_code_dir/bootstrap-scripts", "$fc_code_dir/workstation", "$fc_code_dir/twilio-pager" ]:
    ensure => latest,
    provider => git,
  }


  exec { 'bootstrap puppetmaster as feralcoder type':
    command => "$fc_code_dir/bootstrap-scripts/feralcoder.sh",
    creates => "/root/.local_settings",
    user => 'root',
    environment => [ 'HOME=/root' ],
  }
  exec { 'update from workstation script':
    command => "$fc_code_dir/workstation/update.sh",
    user => 'root',
    environment => [ 'HOME=/root' ],
  }


  # Allow one run of admin scripts to place /etc/hosts
  # Then lock in place, managed by puppet from here.
  exec { 'set hosts lock':
    # Wait for hosts to be placed by workstation/update.sh before locking
    command => '/usr/bin/grep "HOSTS FROM WORKSTATION CONFIGURATION" /etc/hosts >/dev/null && touch /etc/hosts_managed_dont_clobber',
    creates => '/etc/hosts_managed_dont_clobber',
  }
  file_line { 'set puppetmaster in /etc/hosts':
    path => '/etc/hosts',
    match => '.*puppetmaster.feralcoder.org',
    line => "$serverip    puppetmaster.feralcoder.org puppetmaster",
  }
}
