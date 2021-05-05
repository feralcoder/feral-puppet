# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include fc_common::facts
class fc_common::facts {
  # Using exec instead of file resource to break dependency cycle
  exec { 'create parent directories for facter...':
    command => "/usr/bin/mkdir -p /etc/facter/facts.d/"
  }

  file { '/etc/facter/facts.d/decrypt.txt':
    ensure => file,
    source => [ "puppet:///modules/fc_common/facts_decrypt.txt" ],
    mode => "0600"
  }
  ~> refacter { 'reload after decrypt key placed': patterns => [ "^fc_common_decrypt_key" ] }

  file { '/etc/facter/facts.d/cliff_key.txt':
    ensure => file,
    source => [ "puppet:///modules/fc_common/facts_cliff_key.txt" ],
    mode => "0600"
  }
  ~> refacter { 'reload after cliff key placed': patterns => [ "^fc_common_cliff_key" ] }
}
