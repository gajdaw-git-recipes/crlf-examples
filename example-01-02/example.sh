#!/usr/bin/env bash
set -x

rm -rf run

mkdir run
cd run

mkdir example
cd example
git init
git config --global core.autocrlf false
printf "linux \n a" > linux.zip
printf "win \r\n a" > win.zip
printf "mix \r\n a \n b " > mix.zip
printf "mix2 \r\n a \n b \r c" > mix2.zip
echo "* text=auto" > .gitattributes
git add -A
git commit -m first
cd ..

git config --global core.autocrlf false
git clone example  example-test
cd example-test
hexdump -c linux.zip
hexdump -c win.zip
hexdump -c mix.zip
hexdump -c mix2.zip

# + hexdump -c linux.zip
# 0000000   l   i   n   u   x      \n       a
# 0000009
# + hexdump -c win.zip
# 0000000   w   i   n      \n       a
# 0000007
# + hexdump -c mix.zip
# 0000000   m   i   x      \n       a      \n       b
# 000000c
# + hexdump -c mix2.zip
# 0000000   m   i   x   2      \r  \n       a      \n       b      \r
# 0000010   c
# 0000011

git config --global core.autocrlf false

