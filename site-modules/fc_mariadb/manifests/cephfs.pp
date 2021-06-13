# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include fc_mariadb::cephfs
class fc_mariadb::cephfs {
  ensure_packages ( 'epel-release',
    { ensure => 'present',
        require => Anchor['fc_mariadb::cephfs::begin'],
        before => Anchor['fc_mariadb::cephfs::packages1'],
    }
  )
  ensure_packages ( 'centos-release-ceph-nautilus',
    { ensure => 'present',
        require => Anchor['fc_mariadb::cephfs::packages1'],
        before => Anchor['fc_mariadb::cephfs::packages2'],
    }
  )
  ensure_packages ( 'ceph-common',
    { ensure => 'present',
        require => Anchor['fc_mariadb::cephfs::packages2'],
        before => Anchor['fc_mariadb::cephfs::packages3'],
    }
  )

  anchor { 'fc_mariadb::cephfs::begin': }
  # INSTALL EPEL-RELEASE
  ~> anchor { 'fc_mariadb::cephfs::packages1': }
  # INSTALL CEPH REPOS
  ~> anchor { 'fc_mariadb::cephfs::packages2': }
  # INSTALL CEPH COMMON
  ~> anchor { 'fc_mariadb::cephfs::packages3': }

  ~> file { 'set up cephfs config directory':
    path => '/etc/ceph/',
    ensure => directory,
    mode => '0755',
  }
  ~> file { '/etc/ceph/ceph.client.manila.secret':
    ensure => file,
    content => template('fc_mariadb/ceph.client.manila.secret'),
    mode => '0600',
  }
  ~> file { '/etc/ceph/ceph.client.manila.keyring':
    ensure => file,
    content => template('fc_mariadb/ceph.client.manila.keyring'),
    mode => '0644',
  }
  ~> file { '/etc/ceph/ceph-playlister.conf':
    ensure => file,
    content => template('fc_mariadb/ceph-playlister.conf'),
    mode => '0644',
  }
  ~> file { '/etc/ceph/manila-playlister-share-path':
    ensure => file,
    content => template('fc_mariadb/manila-playlister-share-path'),
    mode => '0644',
  }
  ~> file { 'set up cephfs mount path for mariadb':
    path => '/cephfs-data/',
    ensure => directory,
    mode => '0755',
    owner => 'mysql',
    group => 'mysql',
  }
  ~> mount { 'set up cephfs-data mount':
    ensure => 'mounted',
    device => "$fc_playlister::cephfs_list:$fc_playlister::manila_path",
    name => '/cephfs-data',
    fstype => 'ceph',
    options => 'name=manila,secretfile=/etc/ceph/ceph.client.manila.secret,noatime,_netdev',
  }
  ~> anchor { 'fc_mariadb::cephfs::end': }
}
