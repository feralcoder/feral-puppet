# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include feralcoder_puppetmaster::crypt::key
class feralcoder_puppetmaster::crypt::key {
  file { '/etc/puppetlabs/code/environments/production/site-modules/feralcoder_common/files/':
    ensure => directory,
    owner => 'puppet',
    group => 'wheel',
    mode => '0750'
  }
  file { '/etc/puppetlabs/code/environments/production/site-modules/feralcoder_common/files/decrypt_secret':
    content => $fc_puppet_decrypt_key,
    mode => '0600',
    owner => 'puppet'
  }
  file { '/etc/puppetlabs/code/environments/production/site-modules/feralcoder_common/files/facts_decrypt.txt':
    source => [ '/etc/facter/facts.d/decrypt.txt' ],
    mode => '0600',
    owner => 'puppet'
  }
}
