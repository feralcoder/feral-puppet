# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include image_updater
class image_updater {
  class { 'image_updater::users': } ~>
  class { 'image_updater::secrets': } ~>
  class { 'image_updater::ssh': } ~>
  class { 'image_updater::yum': } ~>
  class { 'image_updater::zeroes': } ~>
  class { 'image_updater::reboot': }
}
