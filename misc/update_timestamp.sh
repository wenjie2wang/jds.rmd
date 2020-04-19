#!/bin/bash

# Note: this script is should be sourced from the project root directory

set -e

# define some variables
yr=$(date +%Y)
dt=$(date +%Y-%m-%d)
# update date in DESCRIPTION
regexp2="s/Date: [0-9]{4}-[0-9]{1,2}-[0-9]{1,2}/Date: $dt/"

if [ "$(uname)" = "Linux" ]
then
    sed -i -E "$regexp2" DESCRIPTION
    printf "Updated package date.\n"
elif [ "$(uname)" = "Darwin" ]
then
    sed -E "$regexp2" DESCRIPTION > .DESCRIPTION
    mv .DESCRIPTION DESCRIPTION
    printf "Updated package date.\n"
else
    printf "Remeber to update date and version number.\n"
fi
