<?php

/**
 * Get Font
 */

$options = getopt('d:');

// load XML
$xml = simplexml_load_file($options['d']);

// search for one of these
$defaults = array(
	'ComicSansMSB',
	'CooperBlackStd',
);

foreach ($defaults as $find) {

	foreach ($xml->type as $font) {

		if ( (string) $font['name'] === $find ) {
			echo (string) $font['name'];
			die();
		}
	}

}

// get random font instead
$fonts = array();

foreach ($xml->type as $font) {

	$fonts[] = (string) $font['name'];

}

echo $fonts[ array_rand($fonts) ];