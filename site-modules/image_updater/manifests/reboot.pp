# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include image_updater::reboot
class image_updater::reboot: {
  file { '/etc/puppet_runs':
    ensure => 'directory',
    mode => '0755'
  }
  file { '/etc/puppet_runs/image_updater_finished':
    ensure => 'file',
    mode => '0644'
  }
  reboot { 'after':
    subscribe       => Exec['dnf update'],
  }
}
