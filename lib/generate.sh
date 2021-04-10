#!/usr/bin/env bash

# Run our Build Script
# This builds the templates in ./templates from our text in ./words
# and outputs the results to ../cjkinni.com
mix run build.ex

# Save any changes
git add .
git commit -m "New Update (Automated)"
git push

# Go to ../cjkinni.com
cd ../cjkinni.com

# Save our changes there for our static site to pickup.
git add .
git commit -m "New Update (Automated)"
git push