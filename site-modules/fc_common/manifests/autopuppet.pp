# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include fc_common::autopuppet
class fc_common::autopuppet {
  anchor { 'fc_common::autopuppet::begin': }
  service { 'enable and start puppet agent':
    name => 'puppet',
    ensure => 'running',
    enable => 'true',
  }
  ~> anchor { 'fc_common::autopuppet::end': }
}
