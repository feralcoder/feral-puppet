# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include image_updater::users
class image_updater::users {
  user { 'cliff':
    ensure => 'present',
    groups => 'wheel',
    managehome => true,
    password => '$6$VLLGwqJm/xteYIlm$nTk5DTjFz7JLL.s6CD4BQQXlMKdyq6Dk3vaOgj7wXGdpMSn2Yfo47wHwuGKe5Su8VctuY3wlBFxe5Qh2pxxER1',
  }
  user { 'root':
    password => '$6$VLLGwqJm/xteYIlm$nTk5DTjFz7JLL.s6CD4BQQXlMKdyq6Dk3vaOgj7wXGdpMSn2Yfo47wHwuGKe5Su8VctuY3wlBFxe5Qh2pxxER1',
  }
}
