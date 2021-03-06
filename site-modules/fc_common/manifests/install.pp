# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include fc_common::install
class fc_common::install {
  if !defined(Package['systemtap']) {
    ensure_packages ( [ 'bcc', 'perf', 'systemtap' ],
      { ensure => present,
        require => Anchor['fc_common::install::begin'],
        before => Anchor['fc_common::install::end'],
      }
  )}

  anchor { 'fc_common::install::begin': }
  ~> anchor { 'fc_common::install::end': }
}
