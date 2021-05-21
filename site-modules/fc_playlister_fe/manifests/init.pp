# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include fc_playlister_fe
class fc_playlister_fe {
  class { 'fc_playlister_fe::install': } ~>
  class { 'fc_playlister_fe::configure': } ~>
  class { 'fc_playlister_fe::service': }
}
