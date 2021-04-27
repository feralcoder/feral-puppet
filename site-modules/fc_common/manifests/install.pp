# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include fc_common::install
class fc_common::install {
    package { 'bcc':
      ensure => installed
    }
    package { 'perf':
      ensure => installed
    }
    package { 'systemtap':
      ensure => installed
    }
}
