#!/bin/bash

options() {
cat << EOF
OPTIONS:
-h    Displays this help message
-f    Font name as it appears in ~/.magick/type.xml
-s    Font size
-t    Text to glitter
-g    Glitter to mask
EOF
}

# Script DIR
pushd `dirname $0` > /dev/null
	DIR="$(dirname `pwd`)"
popd > /dev/null

# Get arguments
while getopts "hf:s:t:g:" OPTION
do
	case "$OPTION" in
		h)
			options
			exit
			;;
		f)
			FONT="$OPTARG"
			;;
		s)
			SIZE="$OPTARG"
			;;
		t)
			TEXT="$OPTARG"
			;;
		g)
			BACKGROUND="$OPTARG"
			;;
	esac
done

# If arguments aren't present, die
if [[ -z $TEXT ]]
then
	options
	exit
fi

# Default Font
if [[ -z $FONT ]]
then
	FONT=ComicSansMSB
fi

# Default Size
if [[ -z $SIZE ]]
then
	SIZE=72
fi

# Default Background
if [[ -z $BACKGROUND ]]
then
	BACKGROUND=$(php $DIR/bin/get_random_file.php -d $DIR/glitter)
fi

# Create mask
convert -fill white -background none -font $FONT \
	-gravity center -pointsize $SIZE label:"$TEXT" \
	mask.gif

# Get mask size
MASK=mask.gif
WIDTH=$(identify -format '%w' "$MASK")
HEIGHT=$(identify -format '%h' "$MASK")

# Create background
convert $BACKGROUND -virtual-pixel tile \
	-set option:distort:viewport "$WIDTH"x"$HEIGHT" -distort SRT 0 \
	tiled-background.gif

# Apply mask to background
TILED=tiled-background.gif
convert $TILED null: $MASK -matte \
	-compose DstIn -layers composite \
	glitter-text.gif

rm $TILED
rm $MASK