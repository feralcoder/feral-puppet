# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include feralcoder_puppetmaster::crypt
class feralcoder_puppetmaster::crypt {
  file { '/etc/puppetlabs/code/environments/production/site-modules/feralcoder_common/files/':
    ensure => directory,
    owner => 'puppet',
    group => 'wheel',
    mode => '0750'
  }
  file { '/etc/puppetlabs/code/environments/production/site-modules/feralcoder_common/files/facts_decrypt.txt':
    source => [ '/etc/facter/facts.d/decrypt.txt' ],
    mode => '0600',
    owner => 'puppet'
  }
}
