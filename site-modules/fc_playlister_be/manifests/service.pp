# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include fc_playlister_be::service
class fc_playlister_be::service {
  service { 'puppet':
    enable => false,
    ensure => stopped,
  }
  anchor { 'fc_playlister_be::service::end': }
}
