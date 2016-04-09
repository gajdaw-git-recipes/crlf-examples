<?php

$data = array(
    "linux \n a" => "linux \\n a",
    "win \r\n a" => "win \\r\\n a",
    "mix \r\n a \n b" => "mix \\r\\n a \\n b",
    "all \r\n a \n b \r c" => "all \\r\\n a \\n b \\r c",
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

