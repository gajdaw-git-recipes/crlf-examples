#!/usr/bin/env bash
set -x

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
echo "* eol=crlf" > .gitattributes
git add -A
git commit -m first
cd ..


git clone example example-test
cd example-test
hexdump -c linux.zip
hexdump -c win.zip
hexdump -c mix.zip

cd ..
cd ..

git config --global core.autocrlf false



#
# Message during git add -A:
#
#    warning: LF will be replaced by CRLF in linux.zip.
#    The file will have its original line endings in your working directory.
#
# Message during git commit
#    warning: LF will be replaced by CRLF in linux.zip.
#    The file will have its original line endings in your working directory.
#
# results in working directory of example-test repository:
#    linux.zip   => line endings CRLF
#    win.xip     => line endings CRLF
#    mix.zip     => line endings: unchanged (\r\n  \n  \r)
#
# conclusions
#    - the conversion LF=>CRLF during check-in is performed
#    - the conversion during check-out is performed
#

