#!/bin/bash

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

hugo -d ../vaibhavk.github.io/
cd ../vaibhavk.github.io

if [[ $(git status -s) ]]
then
    echo "The directory is dirty. Please commit any pending changes."
    cd ../$(dirname "$0")
    exit 1;
fi
# Add changes to git
git add --all
# Commit changes
msg="rebuilding site `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi

git commit -m "$msg"
# Push source and build repos.
git push origin master

# Come Back up to the Project Root
cd ../$(dirname "$0")
