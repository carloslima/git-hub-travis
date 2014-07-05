CMD := git-hub-travis

LOCAL_LIB := $(shell pwd)/lib
LOCAL_LIBS = $(shell find $(LOCAL_LIB) -type f) \
	    $(shell find $(LOCAL_LIB) -type l)

# XXX Make these vars look like git.git/Makefile style
PREFIX ?= /usr/local
INSTALL_LIB ?= $(shell git --exec-path)/git-hub.d
INSTALL_MAN ?= $(PREFIX)/share/man/man1

# # Submodules
TEST_MORE=ext/test-more-bash/lib/test/more.bash
SUBMODULE := $(TEST_MORE)

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
	git submodule update --init --recursive

##
# Build rules:
.PHONY: doc
doc: doc/$(CMD).1 ReadMe.pod

%.1: %.swim
	swim --to=man $< > $@

ReadMe.pod: doc/$(CMD).swim
	swim --to=pod --complete=1 --wrap=1 $< > $@
