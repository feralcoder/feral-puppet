# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include fc_playlister_fe::service
class fc_playlister_fe::service {
  anchor { 'fc_playlister_fe::service::begin': }
  ~> anchor { 'fc_playlister_fe::service::end': }
}
