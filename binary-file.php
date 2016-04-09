<?php


$handle = fopen('data.bin', 'w+');
fwrite($handle, "\0\1\2\0 \n \r\n \r \0\1\2\0");
fclose($handle);