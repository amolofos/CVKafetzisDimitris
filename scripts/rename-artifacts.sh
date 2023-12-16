#!/bin/bash
set -e

VERSION=${VERSION:-v0.0.0}

rootDirectory="${APP_DIR:-.}"
testOutputDirectory="$rootDirectory/target"
artifactsOutputDirectory="$rootDirectory/target/artifacts"

function log {
	echo "`date +'%Y-%m-%d %H:%M:%S'` : $1"
}

log "Renaming artifacts."

mkdir -p $artifactsOutputDirectory

mv $testOutputDirectory/DimitrisKafetzis-cv-en-anonymised.pdf     "${artifactsOutputDirectory}/DimitrisKafetzis-cv-en-anonymised.${VERSION}.pdf"
mv $testOutputDirectory/DimitrisKafetzis-cv-en-colorsAndIcons.pdf "${artifactsOutputDirectory}/DimitrisKafetzis-cv-en-colorsAndIcons.${VERSION}.pdf"
mv $testOutputDirectory/DimitrisKafetzis-cv-en-oneColumn.pdf      "${artifactsOutputDirectory}/DimitrisKafetzis-cv-en-oneColumn.${VERSION}.pdf"
mv $testOutputDirectory/DimitrisKafetzis-cv-en-twoColumn.pdf      "${artifactsOutputDirectory}/DimitrisKafetzis-cv-en-twoColumn.${VERSION}.pdf"

log "Finished."
