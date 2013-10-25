CMD := git-hub

LOCAL_LIB := $(shell pwd)/lib
LOCAL_LIBS = $(shell find $(LOCAL_LIB) -type f) \
	    $(shell find $(LOCAL_LIB) -type l)

# XXX Make these vars look like git.git/Makefile style
PREFIX ?= /usr/local
INSTALL_LIB ?= $(shell git --exec-path)/$(CMD).d
INSTALL_MAN ?= $(PREFIX)/share/man/man1

# # Submodules
# JSON=ext/json-bash/lib/json.bash
# TEST_SIMPLE=ext/test-simple-bash/lib/test-simple.bash
# SUBMODULE := $(JSON) $(TEST_SIMPLE)

## XXX assert good bash

##
# Make sure we have 'git' and it works OK.
ifeq ($(shell which git),)
    $(error 'git' is not installed on this system)
endif
GITVER ?= $(word 3,$(shell git --version))

##
# User targets:
.PHONY: default help test
default: help

help:
	@echo 'Makefile rules:'
	@echo ''
	@echo 'test       Run all tests'
	@echo 'install    Install $(CMD)'
	@echo 'uninstall  Uninstall $(CMD)'

test: $(SUBMODULE)
ifeq ($(shell which prove),)
	@echo '`make test` requires the `prove` utility'
	@exit 1
endif
	prove $(PROVE_OPTIONS) test/

.PHONY: install install-lib install-doc
install: install-lib install-doc

install-lib: $(INSTALL_LIB)
	install -C -d -m 0755 $(INSTALL_LIB)/
	install -C -m 0755 $(LOCAL_LIBS) $(INSTALL_LIB)/

install-doc:
	install -C -d -m 0755 $(INSTALL_MAN)
	install -C -m 0644 doc/$(CMD).1 $(INSTALL_MAN)

.PHONY: uninstall uninstall-lib uninstall-doc
uninstall: uninstall-lib uninstall-doc

uninstall-lib:
	rm -fr $(INSTALL_LIB)

uninstall-doc:
	rm -f $(INSTALL_MAN)/$(CMD).1

##
# Sanity checks:
$(SUBMODULE):
	@echo 'You need to run `git submodule update --init` first.' >&2
	@exit 1

##
# Build rules:
.PHONY: doc
doc: doc/$(CMD).1

$(CMD).txt: readme.asc
	cp $< $@

%.xml: %.txt
	asciidoc -b docbook -d manpage -f doc/asciidoc.conf \
		-agit_version=$(GITVER) $^
	rm $<

%.1: %.xml
	xmlto -m doc/manpage-normal.xsl man $^

doc/%.1: %.1
	mv $< $@

##
# Undocumented dev rules

# Install using symlinks so repo changes can be tested live
.PHONY: dev-install dev-test dev-test-reset check-dev-install
dev-install:
	ln -fs $(LOCAL_LIBS) $(INSTALL_LIB)

# Run a bunch of live tests. Make sure this thing really works. :)
dev-test:
	bash test/dev-test/all_commands.t
	bash test/dev-test/each.t

# Run this to reset if `make dev-test` fails.
dev-test-reset: check-dev-install
	GIT_HUB_TEST_RESET=1 bash test/dev-test/all_commands.t
