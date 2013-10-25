git-hub-travis(1) -- Enable/Disable travis
==========================================

[![Build Status](https://travis-ci.org/carloslima/git-hub-travis.png?branch=master)](https://travis-ci.org/carloslima/git-hub-travis.png?branch=master)

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

## COMMANDS

There are two git-hub-travis commands:

* `git hub travis-enable [<owner>/<repository>]`:

Turn travis on for a repository.

* `git hub travis-disable [<owner>/<repository>]`:

Turn travis off for a repository.

## AUTHOR

Written by Carlos Lima <carlos@bpan.org>
