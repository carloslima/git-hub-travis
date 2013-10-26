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

You will need your travis-ci API token, which you can get here:
https://travis-ci.org/profile/ under the profile tab.

You need to specify your Travis token in one of these ways:

* Set TRAVIS_CI_API_TOKEN environment variable.
* `git hub config travis-ci-api-token <token>`

If the plugin cannot find the token, it will prompt you for it.

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
