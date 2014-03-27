<?php

/**
 * Get a random image
 */

$options = getopt('d:');

// Get all the images
$images = glob("{$options['d']}/*.gif", GLOB_BRACE);

// Choose an image randomly, grabs a random key from an array
echo $images[array_rand($images)];