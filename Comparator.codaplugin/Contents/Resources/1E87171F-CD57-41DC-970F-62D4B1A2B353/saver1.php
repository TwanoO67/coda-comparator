#!/usr/bin/php
<?php

$destination_dir = getenv('HOME').'/codaConfig/';

if (!is_dir($destination_dir)) {
  mkdir($destination_dir);
}

$input = "";

$fp = fopen("php://stdin", "r");
while ( $line = fgets($fp, 1024) )
	$input .= $line;
	
file_put_contents($destination_dir.'CodaCompareFile_Left.tmp', $input);

fclose($fp);

?>