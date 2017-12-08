#!/bin/bash

usage() {
	cat <<EOF
Usage: $(basename $0) <command>

Wrappers around core binaries:
    run                    Runs the http in development mode.
    build                  Builds the http.
    buildDocker            Builds docker image.
    pushDocker             Pushes docker image.
EOF
	exit 1
}

CMD="$1"
shift
case "$CMD" in
	build)
		CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o http -a -tags netgo .
	;;
	run)    
		go run http.go
	;;
	buildDocker)
		docker build -t mateuszdyminski/http:latest .
	;;
    pushDocker)
		docker push mateuszdyminski/http
	;;
	*)
		usage
	;;
esac