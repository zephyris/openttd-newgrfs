# Make grf outputs
# Builds the output grfs (does not process image files from sources)
# If given an argument, copies the grfs to that path once complete
# eg. /my/install/of/openttd/newgrf/

cd newgrf

wget -q -O nml_preprocessor.py https://raw.githubusercontent.com/zephyris/opengfx2/main/templates/nml_preprocessor.py

function buildnewgrf() {
	python3 nml_preprocessor.py ${1} 32ez
	mv ${1}_32ez.nml ${1}.nml
	nmlc ${1}.nml --quiet -c -l lang/${1}
	cp ../README.md readme.txt
	cp ../CHANGELOG.md changelog.txt
	cp ../../LICENSE license.txt
	tar -cf ${1}.tar ${1}.grf readme.txt license.txt changelog.txt
	rm readme.txt license.txt
}

buildnewgrf full-english_uk-townset

if [ ! -z "$1" ]; then
  cp *.grf "$1"
fi

cd ..
