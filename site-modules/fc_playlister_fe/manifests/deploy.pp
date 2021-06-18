# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include fc_playlister_fe::deploy
class fc_playlister_fe::deploy {
  anchor { 'fc_playlister_fe::deploy::begin': }
  ~> exec { 'create cliff CODE directories':
    command => '/usr/bin/mkdir -p /home/cliff/CODE/feralcoder',
    user => 'cliff',
  }
  ~> exec { 'pull latest playlister frontend code':
    command => "/usr/bin/git clone https://feralcoder:`/usr/bin/cat /home/cliff/.git_password`@github.com/feralcoder/playlister-frontend.git /home/cliff/CODE/feralcoder/playlister-frontend",
    creates => "/home/cliff/CODE/feralcoder/playlister-frontend",
    user => 'cliff',
  }
  ~> exec { 'update playlister frontend code':
    command => "/usr/bin/git pull",
    cwd => "/home/cliff/CODE/feralcoder/playlister-frontend",
    user => 'cliff',
  }
  ~> file { '/home/cliff/CODE/feralcoder/playlister-frontend/view/playlister_settings.py':
    ensure => file,
    content => template('fc_playlister_fe/playlister_settings.py'),
    mode => '0644',
    owner => 'cliff',
  }
  ~> file { '/home/cliff/CODE/feralcoder/playlister-frontend/api/playlister_settings.py':
    ensure => file,
    content => template('fc_playlister_fe/playlister_settings.py'),
    mode => '0644',
    owner => 'cliff',
  }
  ~> file { '/lib/systemd/system/playlister-frontend.service':
    ensure => file,
    source => '/home/cliff/CODE/feralcoder/playlister-frontend/playlister-frontend.service',
    mode => '0644',
  }
  ~> exec { 'reload systemd on playlester-frontend deploy':
    command => '/usr/bin/systemctl daemon-reload',
  }
  # USING EXEC INSTEAD OF SERVICE RESOURCE TO SIDESTEP REDUNDANT DECLARATION JFC
  ~> exec { 'stop playlister-frontend pre-deploy':
    command => '/usr/bin/systemctl stop playlister-frontend',
  }
  ~> exec { 'install prerequisites for frontend':
    command => '/home/cliff/CODE/feralcoder/playlister-frontend/venv.sh',
    user => 'cliff',
  }
  # USING EXEC INSTEAD OF SERVICE RESOURCE TO SIDESTEP REDUNDANT DECLARATION JFC
  ~> exec { 'start playlister-frontend post-deploy':
    command => '/usr/bin/systemctl start playlister-frontend',
  }
  ~> anchor { 'fc_playlister_fe::deploy::end': }
}
