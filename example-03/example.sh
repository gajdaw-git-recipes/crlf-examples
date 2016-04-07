#!/usr/bin/env bash
set -x

# the same as example-01 but without core.autocrlf set to true
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
echo "* text=auto" > .gitattributes
git add -A
git commit -m first
cd ..


git clone example  example-test
cd example-test
hexdump -c linux.zip
hexdump -c win.zip
hexdump -c mix.zip

cd ..
cd ..

git config --global core.autocrlf false

# 0000000   l   i   n   u   x      \n       a      \n       b      \n
# 0000010   c
# 0000011
# + hexdump -c win.zip
# 0000000   w   i   n      \n       a      \n       b      \n       c
# 000000f
# + hexdump -c mix.zip
# 0000000   m   i   x      \r  \n       a      \n       b      \r       c
# 0000010


#
# Message during git add -A:
#
#     warning: CRLF will be replaced by LF in win.zip.
#     The file will have its original line endings in your working directory.
#
# Message during git commit:
#
#     warning: CRLF will be replaced by LF in win.zip.
#     The file will have its original line endings in your working directory.
#
# results in working directory of example-test repository:
#    linux.zip   => line endings LF
#    win.xip     => line endings LF
#    mix.zip     => line endings: unchanged (\r\n  \n  \r)
#
# conclusions
#    - the conversion during check-in is performed
#    - the conversion during check-out is not performed
#

