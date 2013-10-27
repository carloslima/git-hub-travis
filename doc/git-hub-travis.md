git-hub-travis(1) - Enable/Disable travis
==========================================

[![Build Status](https://travis-ci.org/carloslima/git-hub-travis.png?branch=master)](https://travis-ci.org/carloslima/git-hub-travis)

## SYNOPSIS

    git hub travis-enable [<repo>]  # Enables travis integration
    git hub travis-disable [<repo>] # Disables travis integration

## DESCRIPTION

This git-hub plugin will let you enable/disable Travis continuous integration
testing for any GitHub repository, from the command line.

## INSTALLATION

Get the source code from GitHub:

    git clone git@github.com:carloslima/git-hub-travis

Then run:

    make test
    make install        # Possibly with 'sudo'

## CONFIGURATION

Travis needs an API token. iYour default git-hub token should be fine.  Learn
about the various tokens here:
http://about.travis-ci.org/blog/2013-01-28-token-token-token/

If you want to use a differnt token look in one of these:

* https://travis-ci.org/profile/ under the profile tab.
* `git hub token-list`

Then set your token of choice in one of these ways:

* Set the TRAVIS_CI_API_TOKEN environment variable.
* `git hub config travis-api-token <token>`

If neither is set, it will default to your `git hub api-token`.

## COMMANDS

There are two git-hub-travis commands:

* `git hub travis-enable [<owner>/<repository>]`

   Turn travis on for a repository.

* `git hub travis-disable [<owner>/<repository>]`

   Turn travis off for a repository. This command actually deletes the hook
   entirely (rather than just deactivating it).

## AUTHOR

Written by Carlos Lima <carlos@bpan.org>

## COPYRIGHT

Copyright 2013 Carlos Lima
