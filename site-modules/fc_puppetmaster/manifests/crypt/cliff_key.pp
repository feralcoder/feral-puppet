# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include fc_puppetmaster::crypt::cliff_key
class fc_puppetmaster::crypt::cliff_key {
  $cliff_public_key_file='/etc/puppetlabs/code/environments/production/site-modules/fc_common/files/facts_cliff_key.txt'
  exec { 'set up cliff public key fact file':
    command => "/usr/bin/cat /home/cliff/.ssh/pubkeys/id_rsa.pub | /usr/bin/sed -e 's/\(.*\)/fc_common_cliff_key=\1/g' > $cliff_public_key_file",
  }
}
