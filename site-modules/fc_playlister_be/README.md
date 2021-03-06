# fc_playlister_be

## FERALCODER NOTES:
Usage of this module is a bit convoluted.  Some crucial configurations live outside the repo.

Puppet enforces states with this module.  But transitions between states are configured
via outside orchestrator: https://github.com/feralcoder/playlister
1) Most code in this module gated on variables set in per-node data file and facts
2) playlister orchestration places initial files for each node, on puppetserver:
2a) ./manifests/playlister2-be-10-254-0-153.novalocal.pp
2b) ./data/nodes/playlister2-be-10-254-0-153.novalocal.yaml
2c) ./site-modules/fc_playlister_be/files/dynamic_facter/playlister2-be-10-254-0-153.novalocal.txt
3) This module takes $node.novalocal.txt file and places it at /etc/facter/facts.d/fc_playlister_be.txt on client
4) X.txt and X.yaml contain state tags which must agree
4a) Once a state is consistently indicated by both files, this module applies state tranitions

This module disables puppet agent, because the playlister orchestrator runs puppet agent to manage
state transitions on nodes, and having an enabled puppet agent introduces potential race conditions
and requires extra logic to recover from concurrent run errors.


## BOILERPLATE

Welcome to your new module. A short overview of the generated parts can be found
in the [PDK documentation][1].

The README template below provides a starting point with details about what
information to include in your README.

## Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with fc_playlister_be](#setup)
    * [What fc_playlister_be affects](#what-fc_playlister_be-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with fc_playlister_be](#beginning-with-fc_playlister_be)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

Briefly tell users why they might want to use your module. Explain what your
module does and what kind of problems users can solve with it.

This should be a fairly short description helps the user decide if your module
is what they want.

## Setup

### What fc_playlister_be affects **OPTIONAL**

If it's obvious what your module touches, you can skip this section. For
example, folks can probably figure out that your mysql_instance module affects
their MySQL instances.

If there's more that they should know about, though, this is the place to
mention:

* Files, packages, services, or operations that the module will alter, impact,
  or execute.
* Dependencies that your module automatically installs.
* Warnings or other important notices.

### Setup Requirements **OPTIONAL**

If your module requires anything extra before setting up (pluginsync enabled,
another module, etc.), mention it here.

If your most recent release breaks compatibility or requires particular steps
for upgrading, you might want to include an additional "Upgrading" section here.

### Beginning with fc_playlister_be

The very basic steps needed for a user to get the module up and running. This
can include setup steps, if necessary, or it can be an example of the most basic
use of the module.

## Usage

Include usage examples for common use cases in the **Usage** section. Show your
users how to use your module to solve problems, and be sure to include code
examples. Include three to five examples of the most important or common tasks a
user can accomplish with your module. Show users how to accomplish more complex
tasks that involve different types, classes, and functions working in tandem.

## Reference

This section is deprecated. Instead, add reference information to your code as
Puppet Strings comments, and then use Strings to generate a REFERENCE.md in your
module. For details on how to add code comments and generate documentation with
Strings, see the [Puppet Strings documentation][2] and [style guide][3].

If you aren't ready to use Strings yet, manually create a REFERENCE.md in the
root of your module directory and list out each of your module's classes,
defined types, facts, functions, Puppet tasks, task plans, and resource types
and providers, along with the parameters for each.

For each element (class, defined type, function, and so on), list:

* The data type, if applicable.
* A description of what the element does.
* Valid values, if the data type doesn't make it obvious.
* Default value, if any.

For example:

```
### `pet::cat`

#### Parameters

##### `meow`

Enables vocalization in your cat. Valid options: 'string'.

Default: 'medium-loud'.
```

## Limitations

In the Limitations section, list any incompatibilities, known issues, or other
warnings.

## Development

In the Development section, tell other users the ground rules for contributing
to your project and how they should submit their work.

## Release Notes/Contributors/Etc. **Optional**

If you aren't using changelog, put your release notes here (though you should
consider using changelog). You can also add any additional sections you feel are
necessary or important to include here. Please use the `##` header.

[1]: https://puppet.com/docs/pdk/latest/pdk_generating_modules.html
[2]: https://puppet.com/docs/puppet/latest/puppet_strings.html
[3]: https://puppet.com/docs/puppet/latest/puppet_strings_style.html
