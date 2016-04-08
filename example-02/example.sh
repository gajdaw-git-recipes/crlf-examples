#!/usr/bin/env bash
set -x

# the same as example-01 but without .gitattributes file
# final output is the same

rm -rf run

mkdir run
cd run

mkdir example
cd example
git init
git config --global core.autocrlf false
printf "linux \n a \n b \n c" > linux.zip
printf "win \r\n a \r\n b \r\n c" > win.zip
printf "mix \r\n a \n b \r c" > mix.zip
printf "mix2 \r\n a \n b " > mix2.zip
git add -A
git commit -m first
cd ..


git config --global core.autocrlf true
git clone example  example-test
cd example-test
hexdump -c linux.zip
hexdump -c win.zip
hexdump -c mix.zip

cd ..
cd ..

git config --global core.autocrlf false

# + hexdump -c linux.zip
# 0000000   l   i   n   u   x      \r  \n       a      \r  \n       b
# 0000010  \r  \n       c
# 0000014
# + hexdump -c win.zip
# 0000000   w   i   n      \r  \n       a      \r  \n       b      \r  \n
# 0000010       c
# 0000012
# + hexdump -c mix.zip
# 0000000   m   i   x      \r  \n       a      \n       b      \r       c
# 0000010


#
# No warnings during git add -A and git commit:
#
# results in working directory of example-test repository:
#    linux.zip   => line endings CRLF
#    win.xip     => line endings CRLF
#    mix.zip     => line endings: unchanged (\r\n  \n  \r)
#
# conclusions
#    - the conversion during check-in is not performed
#    - the conversion during check-out is performed
#

