# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include playlister_fe::install
class playlister_fe::install {
  if $playlister_fe::package_manage {
    package { $playlister_be::haproxy }
  }
}