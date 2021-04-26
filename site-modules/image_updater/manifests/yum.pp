# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include image_updater::yum
class image_updater::yum {
  exec { 'move existing yum repo configs':
    command => "/usr/bin/tar -czf yum.repos`date '+%Y%m%d-%H%M'`.tgz -C /etc/ yum.repos.d"
  }
  exec { 'remove existing yum repo configs':
    command => "/usr/bin/rm -rf /etc/yum.repos.d"
  }
  file { "/tmp/yum.repos.$operatingsystemmajrelease.tgz":
    ensure => file,
    source => [ "puppet:///modules/image_updater/yum.repos.$operatingsystemmajrelease.tgz" ]
  }
  exec { 'unpack yum repos':
    command => "/usr/bin/tar -xzf /tmp/yum.repos.$operatingsystemmajrelease.tgz -C /etc/"
  }

  package { 'tmux':
    ensure => installed
  }
  package { 'git':
    ensure => installed
  }

  exec { 'yum update':
    command => '/usr/bin/yum update -y',
    timeout => 1800
  }

  tidy { '/tmp/yum.repos.$operatingsystemmajrelease.tgz': }

#  class { 'yumupdate': }
}
