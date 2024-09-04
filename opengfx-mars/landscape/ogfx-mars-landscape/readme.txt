My Fancy NewGRF Name
-----------------------------------

Contents:

1 About
2 Usage and Parameters
  2.1 Required settings
  2.2 Advanced configuration
  2.3 Documentation generation
  2.4 Using DevZone build service
  2.5 Translation status reports
  2.6 Using gimp to export layers as png
  2.7 Customizing Makefile targets
3 Building from source
  3.2 Obtaining the source
4 Credits
5 License



-------
1 About
-------

This is a NewGRF build framework

Name of this Repo:  Example NewGRF project
Repository version: 5042



----------------------
2 Usage and Parameters
----------------------

2.1 Required settings
---------------------

Copy the Makefile into the main directory of your NewGRF and create
a Makefile.config which can be copied from the top part of the Makefile.
Makefile.config must contain at least two definitions:

# Definition of the grf's name as shown ingame or in the readme
REPO_NAME           = My NewGRF

# This is the filename part common to the grf file, main source file and the
# tar name
BASE_FILENAME       = mynewgrf


2.2 Advanced configuration
--------------------------

Documtation
-----------
If you want to ship documentation like readme, changelog or license, you can
and should tell the Makefile about it, so that they're automatically included
into the bundles

DOC_FILES = docs/readme.txt docs/license.txt docs/changelog.txt


Custom build parameters for gcc preprocessor
--------------------------------------------
You can pass additional parameters to gcc by use of the CC_USER_FLAGS
variable:
CC_USER_FLAGS = -D PARAM=myvalue


NML requirements
----------------
If your NewGRF requires a certain NML version or branch you can tell the
Makefile to check for that by means of one or both of the following
definitions:

REQUIRED_NML_BRANCH  = 0.3
MIN_NML_REVISION     = 2075


2.3 Documentation generation
----------------------------
You have the option to automatically replace NewGRF title, filename,
version and grfID by the Makefile, so that it remains current even
when you change them. You can do so, if you call your readme
'readme.ptxt' and have the Makefile generate the readme.txt from it.
Then you have a few special commands in the readme.ptxt which will
be replaced:
My NewGRF 2013-10-21 (5042:29c22f945ca5M)      - this is declared in Makefile.config by REPO_NAME
       - this is the grf's filename, e.g. mynewgrf.grf,
                     automatically generated from the BASE_FILENAME as
                     declared in Makefile.config
{{NEWGRF_VERSION}} - NewGRF version reported to OpenTTD. Based on the
                     commit date

Deprecated (do not use!)
5042  - this is determined by the revision in the mercurial repo
                    (REPO_REVISION).


2.4 Using DevZone build service
-------------------------------
The DevZone checks repositories for the presence of a .devzone directory.
In order to activate building you need to add the files as found in the
make-nml repository. You can choose to not add the nightlies or the releases
sub-directories to disable building of nightly or release builds respectively.
The exact filenames must be retained:
.devzone/build/nightlies/enable
.devzone/build/releases/enable
.devzone/build/type


2.5 Translation status reports
------------------------------
You need to add to your repository the nml_langcheck files, the exact
name needs to be retained:
scripts/nml_langcheck.py
scripts/nml_langcheck/__init__.py
scripts/nml_langcheck/languages.py
scripts/nml_langcheck/main.py
scripts/nml_langcheck/output.py

Additionally, if not yet declared, you need to add to Makefile.config the
script dir:

SCRIPT_DIR = scripts

Commit these changes and upon the next build by the DevZone you will
find a 'translations' directory next to the built NewGRF which lists
the status of all translations shipped so far along with your NewGRF.


2.6 Using gimp to export layers as png
--------------------------------------
You need to add to your repository the gimp script files, the exact
names need to be retained:
scripts/gimp.sed
scripts/gimpscript

Additionally, if not yet declared, you need to add to Makefile.config the
script dir:

SCRIPT_DIR = scripts

Further you need to define one or more files which describe which layers
from xcf or psd files shall be exported into which png files. These files
must be made known to the Makefile with their relative path to Makefile,
e.g:

GFX_SCRIPT_LIST_FILES      = gfx/png_source_list.xcf2png

You can list in that line, space separated, as many xcf2png files as you
like. Each must follow a specific format:

* Lines starting with # are ignored and considered comments
* Other lines are interpreted as rules on how to generate a single png file
  and have the format

path/to/file.png    path/to/source.xcf    List Of visible Layer Names Separate By Space

All layers of the xcf or psd file NOT listed explicitly here will be invisible
and not part of the exported png.


2.7 Customizing Makefile targets
--------------------------------
You can apply your own custom Makefile targets without modifying this Makefile
itself - thus you maintain an easy way to update to newer versions of this
build framework while keeping individual rules where needed.

Individual rules need be added in Makefile.in which is placed alongside this
Makefile. You can replace the shipped rules by defining therein the new target
for either of the stages:
GENERATE_NML        ?= nml
GENERATE_LNG        ?= lng
GENERATE_PNML       ?= pnml
GENERATE_DOC        ?= doc
GENERATE_GRF        ?= grf
GENERATE_GFX        ?= gfx

If for instance you would need custom rules for the nml and lng generation
your Makefile.in could look like:
"""
GENERATE_NML := example-nml
GENERATE_LNG := example-lng

example-nml:
	$(_V) new rules go here

example-lng:
	$(_V) new rules go here

clean::
	$(_V) additional cleaning goes here
"""
If you have one build script which generates more than one target, you can all
link that to the same target which calls your build script, saving duplicate
calls of it. In the above example that means to use for instance
GENERATE_NML := example-nml
GENERATE_LNG := example-nml
and only define example-nml

Mind that you cannot overwrite the existing default targets, you need to
choose your own name. The default targets then simply will be ignored.


--------------------
3 Using the Makefile
--------------------

Usually there's not much which needs to be changed when you obtain the
source. Your friends will usually be
    make
    make install

Both will build the grf from source, the latter will also try to copy
the grf into your grf folder so that it is available for testing and
use straight away.

A brief overview over all Makefile targets is given here:

all:
	This is the default target, if also no parameter is given to
	make. It will build the grf file and the documentation and
	bunndle them in a convenient tar for distribution

docs:
	Build the documentation files (if any)

bundle:
	This target will create a directory called "<name>-nightly" and
	copy the grf file there and the documentation files, readme.txt,
	changelog.txt and license.txt

bundle_zip
	This will zip the bundle directory into one zip for distribution

bundle_tar
	This will tar the bundle directory into a tar archive for
	distribution or upload to bananas

bundle_src
	Creates a source bundle

install:
	This will create a tar archive (like bundle_tar) and copy it
	into the INSTALLDIR as specified in Makefile.local (or the
	default dir, if that isn't defined). Don't rely on a good
	detection of the default installation directory. It's
	especially bound to fail on windows machines.

maintainer-clean
	This phony targe cleans everything which can be built by them	Makefile.
	This can also include files which are part of the repository or which
	require specific tools or much time to rebuild (like gimp).

distclean:
	This phony target cleans everything from a source bundle which
	wasn't shipped.

clean:
	This phony target will delete all files which this Makefile will
	create

check:
	Check the md5sum of the built newgrf against the supplied md5sum
	(Intended to be used when building from tar balls; it will fail
	if no source bundle was built previously)



3.2 Obtaining the source
------------------------

The source code can be obtained from the #openttdcoop DevZone at
    http://dev.openttdcoop.org/projects/make-nml
or via mercurial checkout
    hg clone http://hg.openttdcoop.org/make-nml



---------
4 Credits
---------

Author: Ingo von Borstel (aka planetmaker)

Special thanks to #openttdcoop and especially Ammler who provides and
works a lot on maintaining the Development Zone where this repository is
hosted and who also frequently gives much valuable input. Thanks also to
Alberth, Terkhen, Yexo, Rubidium and Ammler who frequently give valuable
input in form of advice and patches to this project. Last but not least
thanks to all the NewGRF authors whose NewGRFs can be my playground for
this project.



---------------
5 License
---------------

make-nml NewGRF build framework
Copyright (C) 2011-2013 planetmaker and others

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License along
with this NewGRF; if not, write to the Free Software Foundation, Inc.,
51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
