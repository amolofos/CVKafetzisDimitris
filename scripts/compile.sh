#!/bin/bash
set -e

testOutputDirectory="$sourceDirectory/target"

sourceDirectory="${APP_DIR:-.}"
testOutputDirectory="$sourceDirectory/target"
templateDirectory="$sourceDirectory/LatexTemplateCVs"
libDirectory="$sourceDirectory/lib"

function log {
	echo "`date +'%Y-%m-%d %H:%M:%S'` : $1"
}

export TEXINPUTS="$TEXINPUTS:$libDirectory"

cd $sourceDirectory
mkdir -p $testOutputDirectory

for f in $(find $sourceDirectory -type f -not -path "$testOutputDirectory/*" -not -path "$templateDirectory/*" -name "*.tex"); do
	log "Compiling file $f."

	pdflatex \
		-halt-on-error \
		-output-directory $testOutputDirectory \
		$f
done

log "Finished."



















function show_help {
  echo "Parameters
* -h : shows this help
* clean : removes the target directory
* compile : compiles the document
* prepare : downloads dependencies for pipeline

E.g
./build.sh -h
./build.sh clean compile
./build.sh clean compile clean
"
}

function log {
	echo "`date +'%Y-%m-%d %H:%M:%S'` : $1"
}

function clean {
	rm -rf $testOutputDirectory
}

function prepare {
	log "Prepare: Docker build $docker_image_name image."
	docker build \
		-t $docker_image_name \
		-f $docker_file \
		.

	log "Prepare: Create $testOutputDirectory directory."
	mkdir -p $testOutputDirectory
}

function compile {
	prepare

	docker rm -f $docker_image_name 2>&1 && \
	docker run \
		-v     "$sourceDirectory:/opt/data" \
		--name $docker_image_name \
		-it \
		$docker_image_name \
		/bin/bash

}


while getopts "h?vf:" opt; do
	case "$opt" in
		h|\?)
			show_help
			exit 0
			;;
	esac
done

# After the below, we will have the non switch based parameters into $@.
shift $((OPTIND-1))
[ "${1:-}" = "--" ] && shift

if [ "$#" -eq 0 ]; then
	show_help
	exit 0
fi

log $@
for stage in $@; do
	log "Processing stage = $stage."
	eval $stage
done

log "Finished."
