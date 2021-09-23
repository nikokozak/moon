#!/bin/bash

ruby src/test/tests.rb
if [ $? != 0 ]
then
    echo "There was an error during testing - BUILD ABORTED"
fi

mkdir -p dist/moon
cp -r src/* dist/moon
tar -czvf dist/moon.tar.gz dist/moon
rm -rf dist/moon
