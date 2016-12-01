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
printf "linux \n a" > linux.abc
printf "win \r\n a" > win.abc
printf "mix \r\n a \n b" > mix.abc
printf "all \r\n a \n b \r c" > all.abc
cp ../../../data.bin .

echo "*.txt text=auto" > .gitattributes
echo "*.txt eol=lf" >> .gitattributes
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
hexdump -c linux.abc
hexdump -c win.abc
hexdump -c mix.abc
hexdump -c all.abc
hexdump -c data.bin

hexdump -c linux.txt > ../../output.txt
hexdump -c win.txt >> ../../output.txt
hexdump -c mix.txt >> ../../output.txt
hexdump -c all.txt >> ../../output.txt
hexdump -c linux.abc >> ../../output.txt
hexdump -c win.abc >> ../../output.txt
hexdump -c mix.abc >> ../../output.txt
hexdump -c all.abc >> ../../output.txt
hexdump -c data.bin >> ../../output.txt

git config --global core.autocrlf false
