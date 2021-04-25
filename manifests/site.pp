## site.pp ##

# This file (./manifests/site.pp) is the main entry point
# used when an agent connects to a master and asks for an updated configuration.
# https://puppet.com/docs/puppet/latest/dirs_manifest.html
#
# Global objects like filebuckets and resource defaults should go in this file,
# as should the default node definition if you want to use it.

## Active Configurations ##

# Disable filebucket by default for all File resources:
# https://github.com/puppetlabs/docs-archive/blob/master/pe/2015.3/release_notes.markdown#filebucket-resource-no-longer-created-by-default
File { backup => false }

## Node Definitions ##

# The default node definition matches any node lacking a more specific node
# definition. If there are no other node definitions in this file, classes
# and resources declared in the default node definition will be included in
# every node's catalog.
#
# Note that node definitions in this file are merged with node data from the
# Puppet Enterprise console and External Node Classifiers (ENC's).
#
# For more on node definitions, see: https://puppet.com/docs/puppet/latest/lang_node_definitions.html
#node 'puppetmaster.feralcoder.org' {
#  class { 'puppetdb':
#    listen_address => 'puppetmaster.feralcoder.org'
#  }
#  class { 'puppetdb::master::config':
##    strict_validation => false
#  }
#}

#puppetdb::master::config::strict_validation: false

stage { 'puppet-init':
  before => Stage['main']
}
stage { 'puppetmaster-init':
  before => Stage['puppet-init']
}

node default {
  class { 'feralcoder_common::decrypt_key':
    stage => 'puppet-init'
  }
  class { 'feralcoder_common::install': }
}

node puppetmaster.feralcoder.org {
  class { 'feralcoder_puppetmaster::crypt':
    stage => 'puppetmaster-init'
  }
}
