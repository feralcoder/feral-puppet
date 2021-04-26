# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include image_updater::reboot
class image_updater::reboot {
  reboot { 'after':
    subscribe       => Exec['dnf update'],
  }
}
