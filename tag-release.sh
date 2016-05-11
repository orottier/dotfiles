#!/bin/bash

# get latest annotated tag on this branch
latest=$(git describe --abbrev=0)

# strip the first char, and add 1: r12 -> 12 -> 13 -> r13
new="r"$((${latest:1}+1))

# create the tag locally, add the deploy message as description
git tag -a $new -m "$1"

# push the new tag
git push origin $new
