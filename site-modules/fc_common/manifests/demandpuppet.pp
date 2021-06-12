# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include fc_common::demandpuppet
class fc_common::demandpuppet {
  anchor { 'fc_common::demandpuppet::begin': }
  service { 'disable and stop puppet agent':
    name => 'puppet',
    ensure => 'stopped',
    enable => 'false',
  }
  ~> anchor { 'fc_common::demandpuppet::end': }
}
