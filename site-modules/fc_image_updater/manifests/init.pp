# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include fc_image_updater
class fc_image_updater {
  class { 'fc_image_updater::users': } ~>
  class { 'fc_image_updater::secrets': } ~>
  class { 'fc_image_updater::ssh': } ~>
  class { 'fc_image_updater::yum': } ~>
  class { 'fc_image_updater::zeroes': } ~>
  class { 'fc_image_updater::reboot': }
}
