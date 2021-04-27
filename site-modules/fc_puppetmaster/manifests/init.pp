# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include fc_puppetmaster
class fc_puppetmaster {
  class { 'fc_admin': } ~>
  class { 'fc_puppetmaster::configure': } ~>
  class { 'fc_puppetmaster::install': }
}
