clean:
	./scripts/build.sh clean

help:
	./scripts/build.sh -h

build:
	./scripts/build.sh clean compile

rename_artifacts:
	./scripts/rename-artifacts.sh
