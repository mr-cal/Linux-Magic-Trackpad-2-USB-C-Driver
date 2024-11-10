#! /bin/bash

# the release process is simple - there is only one release called 'latest'

git tag --delete latest
git push --delete origin latest

git tag -s -a -m "latest" latest
git push origin latest
