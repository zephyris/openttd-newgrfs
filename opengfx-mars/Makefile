#     OpenGFX Mars
#     Copyright (C) 2014 Zephyris, Alberth, Elyon, planetmaker and others
#     Contact: planetmaker@openttd.org
#
#     This program is free software; you can redistribute it and/or modify
#     it under the terms of the GNU General Public License as published by
#     the Free Software Foundation; either version 2 of the License, or
#     (at your option) any later version.
#
#     This program is distributed in the hope that it will be useful,
#     but WITHOUT ANY WARRANTY; without even the implied warranty of
#     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#     GNU General Public License for more details.
#
#     You should have received a copy of the GNU General Public License along
#     with this program; if not, write to the Free Software Foundation, Inc.,
#     51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
#

# Remove the @ when you want a more verbose output.
_V ?= @
_E ?= @echo

PROJECTS ?= $(shell cat .devzone/build/projects)

# general definitions (no rules!)
.PHONY: all update-all $(PROJECTS)

# We want to disable the default rules. It's not c/c++ anyway
.SUFFIXES:

all clean distclean doc bundle bundle_bsrc bundle_bzip bundle_gsrc bundle_src bundle_tar bundle_xsrc bundle_xz bundle_zip bundle_zsrc check grf nml doc: $(PROJECTS)

$(PROJECTS):
	$(_V) +$(MAKE) -C $@ $(MAKEFLAGS) $(MAKECMDGOALS) VERSION_SCRIPT=../findversion.sh


update-all:
	$(_V) for i in ${PROJECTS}; do hg pull -u -R $i; done
	$(_V) hg pull -u -R graphics
