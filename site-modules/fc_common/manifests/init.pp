# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include fc_common
class fc_common {
  class { 'fc_common::config': } ~>
  class { 'fc_common::install': }
}
