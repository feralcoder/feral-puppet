# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include fc_common::decrypt_key
class fc_common::decrypt_key {

  # Using exec instead of file resource to break dependency cycle
  exec { 'create parent directories for facter...':
    command => "/usr/bin/mkdir -p /etc/facter/facts.d/"
  }
#  file { [ '/etc/facter/', '/etc/facter/facts.d/' ]:
#    ensure => directory,
#    owner => 'root',
#    group => 'wheel',
#    mode => '0750'
#  }

  file { '/etc/facter/facts.d/decrypt.txt':
    ensure => file,
    source => [ "puppet:///modules/fc_common/facts_decrypt.txt" ],
    mode => "0600"
  }
  ~> refacter { 'reload after decrypt key placed': patterns => [ "^fc_puppet_decrypt_key" ] }

  file { '/tmp/test.txt':
    ensure => file,
    content => "secret is $fc_puppet_decrypt_key"
  }
}
