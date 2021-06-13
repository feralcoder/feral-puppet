# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include fc_puppetmaster::install
class fc_puppetmaster::install {
  ensure_packages ( ['puppetserver', 'pdk' ],
    { ensure => present,
    }
  )

  exec { 'install puppetlabs-stdlib puppet module':
    command => "/opt/puppetlabs/bin/puppet module install puppetlabs-stdlib"
  }
  exec { 'install puppetlabs-vcsrepo puppet module':
    command => "/opt/puppetlabs/bin/puppet module install puppetlabs-vcsrepo"
  }
  exec { 'install puppetlabs-reboot puppet module':
    command => "/opt/puppetlabs/bin/puppet module install puppetlabs-reboot"
  }
  exec { 'install morpheu-refacter puppet module':
    command => "/opt/puppetlabs/bin/puppet module install morpheu-refacter"
  }

  file { 'autoaccept all host certs':
    ensure => file,
    content => '*',
    path => '/etc/puppetlabs/autosign.conf'
  }
}
