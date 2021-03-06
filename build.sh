#!/bin/bash

# brew install ming-w64

rm -fr dist/*

for GOOS in darwin linux windows; do
	for GOARCH in 386 amd64; do
		echo "Building $GOOS-$GOARCH"

		DISTPATH=

		if [ "${GOOS}" == "windows" ]; then
			if [ "${GOARCH}" == "386" ]; then
				env GOOS="${GOOS}" GOARCH="${GOARCH}" CGO_ENABLED=1 CC="/usr/local/opt/mingw-w64/bin/i686-w64-mingw32-gcc" go build -o "dist/ibus2cin.exe"
			else
				env GOOS="${GOOS}" GOARCH="${GOARCH}" CGO_ENABLED=1 CC="/usr/local/opt/mingw-w64/bin/x86_64-w64-mingw32-gcc" go build -o "dist/ibus2cin.exe"
			fi
			tar zcf "dist/ibus2cin-${GOOS}-${GOARCH}.tar.gz" "dist/ibus2cin.exe"
		else
			env GOOS="${GOOS}" GOARCH="${GOARCH}" go build -o "dist/ibus2cin"
			tar zcf "dist/ibus2cin-${GOOS}-${GOARCH}.tar.gz" "dist/ibus2cin"
		fi


	done
done

rm dist/ibus2cin.exe
rm dist/ibus2cin
