# Puppet-desktop

## Introduction

This repository contains a set of shell scripts and puppet manifests to install and customize an Ubuntu desktop environment.

It aims to provide an initial configuration after a fresh install (ie. repetitive tasks I usually do after (re)installing a machine).


## Usage

To apply the default manifest included in this repository, you can use the following shell command :

```sh
$ wget -O- -q https://raw.githubusercontent.com/lionelnicolas/puppet-desktop/master/bootstrap.sh | sudo sh
```


Some environment variables can be used to override installation sources:
* `WGET_URL` : point to the puppet manifests tarball (defaults to this repository)
* `GIT_URL` : if set, this URL will be used to clone a git repository which contains puppet manifests (instead of using tarball)
* `INIT_URL` : if set, the `manifests/init.pp` file will be overwritten by the one got from this URL before applying puppet

For example:
```sh
$ sudo -i
$ export GIT_URL="git://my.private.repository/puppet.git"
$ export INIT_URL="http://my.private.server/data/custom-bootstrap.pp"
$ wget -O- -q https://raw.githubusercontent.com/lionelnicolas/puppet-desktop/master/bootstrap.sh | sh
```


Note: when using environment variables, you need to be root (`sudo -i`) before exporting variables. On some configurations, sudo could drop them if piping wget output to `sudo sh` (see `Command environment` in [sudoers manpage](http://www.sudo.ws/sudoers.man.html)).


## Authors

**Lionel Nicolas**


## Copyright and license

These scripts are made available under the terms of the [GPLv3](http://www.gnu.org/licenses/gpl.html).

Copyright 2014 Lionel Nicolas <lionel.nicolas@nividic.org>

