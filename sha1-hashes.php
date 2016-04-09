<?php

$data = array(
    "linux \n a" => "linux \\n a",
    "linux \r\n a" => "linux \\r\\n a",
    "win \r\n a" => "win \\r\\n a",
    "win \n a" => "win \\n a",
    "mix \r\n a \n b" => "mix \\r\\n a \\n b",
    "mix \n a \n b" => "mix \\n a \\n b",
    "mix \r\n a \r\n b" => "mix \\r\\n a \\r\\n b",
    "all \r\n a \n b \r c" => "all \\r\\n a \\n b \\r c",
    "all \n a \n b \r c" => "all \\n a \\n b \\r c",
    "all \r\n a \r\n b \r c" => "all \\r\\n a \\r\\n b \\r c",
    "\0\1\2\0 \n \r\n \r \0\1\2\0" => "\\0\\1\\2\\0 \\n \\r\\n \\r \\0\\1\\2\\0",
    "\0\1\2\0 \n \n \r \0\1\2\0" => "\\0\\1\\2\\0 \\n \\n \\r \\0\\1\\2\\0",
    "\0\1\2\0 \r\n \r\n \r \0\1\2\0" => "\\0\\1\\2\\0 \\r\\n \\r\\n \\r \\0\\1\\2\\0",
);

echo "=============================================\n";
foreach ($data as $k => $v) {

    $content = $k;
    echo $v;

    echo "\n";

    $header = 'blob ' . strlen($content) . "\0" ;
    $store = $header . $content;
    echo sha1($store);

    echo "\n=============================================\n";
}

