#!/bin/bash

year=2022

aoc_path="${BASH_SOURCE[0]%/*}"
day="day$(printf %02d $1)"
day_path="$aoc_path/$day"

cookie=$(cat $aoc_path/cookie)

if [[ -d "$day_path" ]]; then
    echo "A directory for that day already exists!"
    exit 1
fi

# clone template
cp -r "$aoc_path/template" "$day_path"
mv "$day_path/template.py" "$day_path/$day.py"
mv "$day_path/template.lisp" "$day_path/$day.lisp"

# get input
wget "https://adventofcode.com/$year/day/$1/input" \
    -P "$day_path" \
    --header="cookie: $cookie"

echo "created $day_path"
