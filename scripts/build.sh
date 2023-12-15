#!/bin/bash
set -e

# Reset in case getopts has been used previously in the shell.
OPTIND=1

sourceDirectory=$(pwd)
testOutputDirectory="$sourceDirectory/target"
templateDirectory="$sourceDirectory/LatexTemplateCVs"
libDirectory="$sourceDirectory/lib"

export TEXINPUTS="$libDirectory:$TEXINPUTS"

function show_help {
  echo "Parameters
* -h : shows this help
* clean : removes the target directory
* compile : compiles the document
* prepare_pipeline: downloads dependencies for pipeline
* compile_pipeline: build project in pipeline

E.g
./build.sh -h
./build.sh clean compile
./build.sh clean compile clean
./build.sh prepare_pipeline compile_pipeline
"
}

function log {
	echo "`date +'%Y-%m-%d %H:%M:%S'` : $1"
}

function clean {
	rm -rf $testOutputDirectory
}

function prepare_pipeline {
  wget https://raw.githubusercontent.com/blang/latex-docker/master/latexdockercmd.sh
  chmod +x latexdockercmd.sh
}

function compile {
	mkdir -p $testOutputDirectory

	for f in $(find $sourceDirectory -type f -not -path "$testOutputDirectory/*" -not -path "$templateDirectory/*" -name "*.tex"); do
		log "Compiling file $f."

		pdflatex \
			-halt-on-error \
			-output-directory $testOutputDirectory \
			$f
	done
}

function compile_pipeline {
  ./latexdockercmd.sh ./scripts/build.sh clean compile
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

log "Environment variables"
env

log $@
for stage in $@; do
	log "Processing stage = $stage."
	eval $stage
done

log "Finished."
