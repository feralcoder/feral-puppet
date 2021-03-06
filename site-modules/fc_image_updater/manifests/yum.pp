# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include fc_image_updater::yum
class fc_image_updater::yum {
  if !defined(Package['tmux']) {
    ensure_packages { 'tmux',
    { ensure => present,
        require => Anchor['fc_image_updater::yum::late'],
        before => Anchor['fc_image_updater::yum::end'],
    }
  )}
  if !defined(Package['git']) {
    ensure_packages { 'git',
    { ensure => present,
        require => Anchor['fc_image_updater::yum::late'],
        before => Anchor['fc_image_updater::yum::end'],
    }
  )}

  anchor { 'fc_image_updater::yum::begin': }

  ~> exec { 'move existing yum repo configs':
    command => "/usr/bin/tar -czf /etc/yum.repos`date '+%Y%m%d-%H%M'`.tgz -C /etc/ yum.repos.d"
  }
  ~> exec { 'remove existing yum repo configs':
    command => "/usr/bin/rm -rf /etc/yum.repos.d"
  }
  ~> file { "/tmp/yum.repos.$operatingsystemmajrelease.tgz":
    ensure => file,
    source => [ "puppet:///modules/fc_image_updater/yum.repos.$operatingsystemmajrelease.tgz" ]
  }
  ~> exec { 'unpack yum repos':
    command => "/usr/bin/tar -xzf /tmp/yum.repos.$operatingsystemmajrelease.tgz -C /etc/"
  }


  ~> exec { 'yum update':
    command => '/usr/bin/yum update -y',
    timeout => 1800
  }

  ~> tidy { '/tmp/yum.repos.$operatingsystemmajrelease.tgz': }

  ~> anchor { 'fc_image_updater::yum::late': }
  # INSTALL TMUX, GIT
  ~> anchor { 'fc_image_updater::yum::end': }
}
