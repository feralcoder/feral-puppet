# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include image_updater::secrets
class image_updater::secrets {
  $decrypt_secret_file='/tmp/decrypt_secret'
  $image_build_files='/etc/puppetlabs/code/environments/production/site-modules/image_updater/files'
  $git_pass_file_enc="$image_build_files/git_password.encrypted"
  $cliff_pass_file_enc="$image_build_files/cliff_password.encrypted"
  $cliff_ssh_file_enc="$image_build_files/cliff_ssh.tgz.encrypted"

  file { "$decrypt_secret_file":
    content => "$fc_puppet_decrypt_key",
    mode => "0600"
  }


  file { '/tmp/git_password.encrypted':
    ensure => file,
    source => [ 'puppet:///modules/image_updater/git_password.encrypted' ],
    mode => '0600'
  }
  exec { 'cliff git_password':
    command => "/usr/bin/openssl enc -d -aes-256-cfb8 -md sha256 -in /tmp/git_password.encrypted -out /home/cliff/.git_password -pass file:$decrypt_secret_file"
  }
  ~> file { "/home/cliff/.git_password":
    mode => '0600',
    owner => 'cliff'
  }
  exec { 'centos git_password':
    command => "/usr/bin/openssl enc -d -aes-256-cfb8 -md sha256 -in /tmp/git_password.encrypted -out /home/centos/.git_password -pass file:$decrypt_secret_file"
  }
  ~> file { "/home/centos/.git_password":
    mode => '0600',
    owner => 'centos'
  }
  exec { 'root git_password':
    command => "/usr/bin/openssl enc -d -aes-256-cfb8 -md sha256 -in /tmp/git_password.encrypted -out /root/.git_password -pass file:$decrypt_secret_file"
  }
  ~> file { "/root/.git_password":
    mode => '0600',
    owner => 'root'
  }

  

  file { '/tmp/cliff_password.encrypted':
    ensure => file,
    source => [ 'puppet:///modules/image_updater/cliff_password.encrypted' ],
    mode => '0600'
  }
  exec { 'decrypt cliff_password':
    command => "/usr/bin/openssl enc -d -aes-256-cfb8 -md sha256 -in /tmp/cliff_password.encrypted -out /home/cliff/.password -pass file:$decrypt_secret_file"
  }
  ~> file { "/home/cliff/.password":
    mode => '0600',
    owner => 'cliff'
  }

  
  file { '/tmp/cliff_ssh.tgz.encrypted':
    ensure => file,
    source => [ 'puppet:///modules/image_updater/cliff_ssh.tgz.encrypted' ],
    mode => '0600'
  }
  exec { 'decrypt cliff ssh.tgz':
    command => "/usr/bin/openssl enc -d -aes-256-cfb8 -md sha256 -in /tmp/cliff_ssh.tgz.encrypted -out /home/cliff/ssh.tgz -pass file:$decrypt_secret_file"
  }
  ~> file { '/home/cliff/ssh.tgz':
    mode => '0600',
    owner => 'cliff'
  }
  ~> exec { 'package cliff .ssh':
    command => "/usr/bin/tar -xzf /home/cliff/ssh.tgz -C /home/cliff/"
  }


  tidy { [ '/tmp/git_password.encrypted', '/tmp/cliff_password.encrypted', '/tmp/cliff_ssh.tgz.encrypted' ]: }
}
