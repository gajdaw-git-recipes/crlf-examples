#!/usr/bin/env bash
set -x

rm -rf run

mkdir run
cd run

mkdir example
cd example
git init
git config --global core.autocrlf false

printf "linux \n a" > linux.txt
printf "win \r\n a" > win.txt
printf "mix \r\n a \n b" > mix.txt
printf "all \r\n a \n b \r c" > all.txt
cp ../../../data.bin .

# this rule is missleading
# auto has no effect
# eol=lf turns on normalization for all files
# compare example-01-04
echo "* text=auto eol=lf" > .gitattributes

git add -A
git commit -m first
cd ..

git config --global core.autocrlf false
git clone example example-test
cd example-test

hexdump -c linux.txt
hexdump -c win.txt
hexdump -c mix.txt
hexdump -c all.txt
hexdump -c data.bin

hexdump -c linux.txt > ../../output.txt
hexdump -c win.txt >> ../../output.txt
hexdump -c mix.txt >> ../../output.txt
hexdump -c all.txt >> ../../output.txt
hexdump -c data.bin >> ../../output.txt

git config --global core.autocrlf false
