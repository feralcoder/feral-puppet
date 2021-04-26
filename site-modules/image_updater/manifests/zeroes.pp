# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include image_updater::zeroes
class image_updater::zeroes {
  exec { 'zero out image':
    command => "/usr/bin/dd if=/dev/zero of=/fill_me_up bs=1M || true",
    timeout => 1800
  }
  exec { 'remove zeroes':
    command => "/usr/bin/rm /fill_me_up || true"
  }
}
