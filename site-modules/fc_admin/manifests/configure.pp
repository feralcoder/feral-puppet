# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include fc_admin::configure
class fc_admin::configure {
  $code_dir='/home/cliff/CODE'
  $fc_code_dir="$code_dir/feralcoder"
  $git_password_file='/home/cliff/.git_password'

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
