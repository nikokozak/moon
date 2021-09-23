#!/bin/bash

ruby src/test/tests.rb
if [ $? != 0 ]
then
    echo "There was an error during testing - BUILD ABORTED"
fi

mkdir -p dist/moon
cp -r src/* dist/moon
tar -c -f dist/0.0.1.tar -C dist/moon .
rm -rf dist/moon
