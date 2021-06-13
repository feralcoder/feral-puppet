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
  ~> anchor { 'fc_playlister_fe::deploy::end': }
}
