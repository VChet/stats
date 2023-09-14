#!/usr/bin/env bash
set -e

# move the generated files to temporary directory
mv -v generated /tmp/generated

# switch to generated branch
git checkout generated

# set up git
git config user.name "GitHub Actions"
git config user.email "actions@github.com"

# clean up
# git rm -rf --ignore-unmatch *
rm -rf *
mv -v /tmp/generated/* .

# commit
git add --all

# Check if there are changes to commit
if git diff-index --quiet HEAD; then
  echo "No changes to commit. Exiting."
  exit 0
fi

if [ -z "$SCHEDULED_ACTION" ]; then
  git commit -m "Update generated files: $GITHUB_SHA"
else
  git commit -m "Update generated files (scheduled)"
fi

git push origin generated
