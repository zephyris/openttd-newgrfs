# Make grf outputs
# Builds the output grfs (does not process image files from sources)
# If given an argument, copies the grfs to that path once complete
# eg. /my/install/of/openttd/newgrf/

function buildnewgrf() {
	nmlc ${1}.nml --quiet -c
	cp README.md readme.txt
	cp CHANGELOG.md changelog.txt
	cp ../LICENSE license.txt
	tar -cf ${1}.tar ${1}.grf readme.txt license.txt changelog.txt
	rm readme.txt license.txt changelog.txt
}

buildnewgrf ekranoplan

if [ ! -z "$1" ]; then
  cp *.grf "$1"
fi

