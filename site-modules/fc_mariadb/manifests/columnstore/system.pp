# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include fc_mariadb::columnstore::system
class fc_mariadb::columnstore::system {
  file { '/etc/sysctl.d/90-mariadb-enterprise-columnstore.conf':
    ensure => file,
    source => 'puppet:///modules/fc_mariadb/90-mariadb-columnstore.conf',
    mode => '0644',
  }
  ~> exec { 'reload sysctl with new changes':
    command => '/usr/sbin/sysctl --load=/etc/sysctl.d/90-mariadb-columnstore.conf',
    subscribe => File['/etc/sysctl.d/90-mariadb-columnstore.conf'],
    refreshonly => true,
  }
  ~> file_line { 'set selinux_permissive':
    line => 'SELINUX=permissive',
    match => '^SELINUX=.*',
    path => '/etc/selinux/config',
  }
  ~> reboot { 'after':
    subscribe => File_line['set selinux_permissive'],
  }
}
