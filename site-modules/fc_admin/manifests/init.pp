# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include fc_admin
class fc_admin {
  class { 'fc_admin::install': } ~>
  class { 'fc_admin::repos': } ~>
  class { 'fc_admin::configure': }
}
