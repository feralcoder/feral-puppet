# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include fc_common::config
class fc_common::config {
  file_line { 'set up cliff in root authorized keys':
    path => '/root/.ssh/authorized_keys',
    line => "$fc_common_cliff_key"
  }
  file_line { 'set up cliff in cliff authorized keys':
    path => '/home/cliff/.ssh/authorized_keys',
    line => "$fc_common_cliff_key"
  }
}
