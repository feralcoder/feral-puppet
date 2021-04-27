# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include fc_puppetmaster::configure
class fc_puppetmaster::configure {
  $code_dir='/etc/puppetlabs/code/environments'
  $git_password_file='/home/cliff/.git_password'

  exec { "set git usage for puppetmaster":
    command => "/usr/bin/git config --global user.name 'Cliff McIntire' && /usr/bin/git config --global user.email 'feralcoder@gmail.com'",
    user => 'root',
    environment => [ 'HOME=/root/' ],
  }

  # This is a chicken-egg situation: needs external setup, and thus will never run if self-bootstrapped
  exec { 'check out puppetmaster configs':
    creates => "$code_dir/production/.git/config",
    command => "/usr/bin/git clone https://feralcoder:`/usr/bin/cat $git_password_file`@github.com/feralcoder/feral-puppet.git $code_dir/production && cd $code_dir/production && git checkout production"
  }
  vcsrepo { "$code_dir/production":
    ensure => latest,
    provider => git,
  }
  
}
