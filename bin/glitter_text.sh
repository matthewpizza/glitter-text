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

directions() {
cat << EOF
Please create list of system font list
Refer to README on imagick_type_gen.pl usage
EOF
}

# Script dir
pushd `dirname $0` > /dev/null
	dir="$(dirname `pwd`)"
popd > /dev/null

# Get arguments
while getopts "hf:s:t:g:" option
do
	case "$option" in
		h)
			options
			exit
			;;
		f)
			font="$OPTARG"
			;;
		s)
			size="$OPTARG"
			;;
		t)
			text="$OPTARG"
			;;
		g)
			background="$OPTARG"
			;;
	esac
done

# If text isn't, die
if [[ -z $text ]]
then
	options
	exit
fi

# Try to create font list if doesn't exit
font_list=~/.magick/type.xml
system_fonts=/Library/Fonts
if [[ ! -f "$font_list" ]]; then
	if [[ ! -d "$system_fonts" ]]
		then
		directions
		exit
	fi

	# Create font list directory
	$(mkdir `dirname "$font_list"`)

	# Generate font list
	$(find $system_fonts -name *.ttf -o -name *.otf | \
		$dir/bin/imagick_type_gen.pl -f - > $font_list)
fi

# Default Font
if [[ -z $font ]]
then
	font=$(php $dir/bin/get_font.php -d $font_list)
fi

# Default Size
if [[ -z $size ]]
then
	size=72
fi

# Default Background
if [[ -z $background ]]
then
	background=$(php $dir/bin/get_random_file.php -d $dir/glitter)
fi

# Create mask
convert -fill white -background none -font $font \
	-gravity center -pointsize $size label:"$text" \
	mask.gif

# Get mask size
mask=mask.gif
width=$(identify -format '%w' "$mask")
height=$(identify -format '%h' "$mask")

# Create background
convert $background -virtual-pixel tile \
	-set option:distort:viewport "$width"x"$height" -distort SRT 0 \
	tiled-background.gif

# Apply mask to background
tiled=tiled-background.gif
convert $tiled null: $mask -matte \
	-compose DstIn -layers composite \
	glitter-text.gif

rm $tiled
rm $mask