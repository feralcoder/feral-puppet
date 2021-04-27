# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include fc_puppetmaster::crypt::files
class fc_puppetmaster::crypt::files {
  $decrypt_secret_file='/etc/puppetlabs/code/environments/production/site-modules/fc_common/files/decrypt_secret'
  $image_build_files='/etc/puppetlabs/code/environments/production/site-modules/fc_image_updater/files'
  $git_pass_file="$image_build_files/git_password"
  $git_pass_file_enc="$image_build_files/git_password.encrypted"
  $cliff_pass_file="$image_build_files/cliff_password"
  $cliff_pass_file_enc="$image_build_files/cliff_password.encrypted"
  $cliff_ssh_file_enc="$image_build_files/cliff_ssh.tgz.encrypted"

  file { "$git_pass_file":
    source => [ '/home/cliff/.git_password' ],
    mode => '0600',
    owner => 'puppet'
  }
  ~> exec { 'encrypt git_password':
    command => "/usr/bin/openssl enc -aes-256-cfb8 -md sha256 -in $git_pass_file -out $git_pass_file_enc --pass file:$decrypt_secret_file"
  }

  file { "$cliff_pass_file":
    source => [ '/home/cliff/.password' ],
    mode => '0600',
    owner => 'puppet'
  }
  ~> exec { 'encrypt cliff_password':
    command => "/usr/bin/openssl enc -aes-256-cfb8 -md sha256 -in $cliff_pass_file -out $cliff_pass_file_enc --pass file:$decrypt_secret_file"
  }

  exec { 'package cliff .ssh':
    command => "/usr/bin/tar -czf /home/cliff/ssh.tgz -C /home/cliff/ .ssh"
  }
  file { '/home/cliff/ssh.tgz':
    mode => '0600',
    owner => 'cliff'
  }
  ~> exec { 'encrypt cliff ssh.tgz':
    command => "/usr/bin/openssl enc -aes-256-cfb8 -md sha256 -in /home/cliff/ssh.tgz -out $cliff_ssh_file_enc --pass file:$decrypt_secret_file"
  }
    


}
