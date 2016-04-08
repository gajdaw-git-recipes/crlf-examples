<?php

$data = array(
    "linux \n a \n b \n c" => "linux \\n a \\n b \\n c",
    "linux \r\n a \r\n b \r\n c" => "linux \\r\\n a \\r\\n b \\r\\n c",
    "win \r\n a \r\n b \r\n c" => "win \\r\\n a \\r\\n b \\r\\n c",
    "win \n a \n b \n c" => "win \\n a \\n b \\n c"
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

