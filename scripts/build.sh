#!/bin/bash
set -e

# Reset in case getopts has been used previously in the shell.
OPTIND=1

function log {
	echo "`date +'%Y-%m-%d %H:%M:%S'` : $1"
}

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

rootDirectory="."
testOutputDirectory="$rootDirectory/target"

docker_image_name="cv-kafetzis-dimitris"
docker_file="$rootDirectory/docker/Dockerfile"
docker_app_dir="${APP_DIR:-/opt/app}"


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

	docker rm -f $docker_image_name 2>&1
	docker run \
		-v     "$testOutputDirectory:$docker_app_dir/$testOutputDirectory" \
		--name $docker_image_name \
		$docker_image_name \
		$docker_app_dir/scripts/compile.sh
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

log "Got $# parameters, these here: $*."

if [ "$#" -eq 0 ]; then
	show_help
	exit 0
fi

for stage in "$@"; do
	log "Processing stage = $stage."
	eval $stage
	log "Finished processing stage = $stage."
done

log "Finished."
