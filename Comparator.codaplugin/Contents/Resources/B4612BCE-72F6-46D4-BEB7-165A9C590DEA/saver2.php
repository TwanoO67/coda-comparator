#!/usr/bin/php
<?php

$input = "";

$fp = fopen("php://stdin", "r");
while ( $line = fgets($fp, 1024) )
	$input .= $line;
	
file_put_contents(getenv('HOME').'/codaConfig/CodaCompareFile_Right.tmp', $input);
	
//print strip_tags($input);
fclose($fp);

?>