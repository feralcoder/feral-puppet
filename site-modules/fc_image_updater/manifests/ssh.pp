# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include fc_image_updater::ssh
class fc_image_updater::ssh {
  file_line { 'enable ssh by password':
    path => '/etc/ssh/sshd_config',
    match => '^PasswordAuthentication',
    line => 'PasswordAuthentication yes'
  }
  service { 'sshd':
    ensure => running,
    subscribe => File_line["enable ssh by password"]
  }
}
