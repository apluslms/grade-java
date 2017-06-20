#!/bin/bash
SCRIPTDIR=`dirname $0`
ARGS=
CP=$1
if [ "$CP" == "" ]; then
	CP=.:/usr/local/jdk/lib/*
fi

# Fix package directories for files uploaded to root.
find . -maxdepth 1 -name \*.java -exec $SCRIPTDIR/addpackagedirs.sh {} +

FILES=`find . -name \*.java`
if [ "$FILES" == "" ]; then
	echo "No files to compile."
	exit 1
fi

# Compile files.
javac -cp $CP $ARGS $FILES
COMPILE_RESULT=$?

# Clean up all source files.
rm $FILES
exit $COMPILE_RESULT
