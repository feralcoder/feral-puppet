# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include playlister_be::install
class playlister_be::install {
  if $playlister_be::package_manage {
    package { $playlister_be::yelp }
  }
}
