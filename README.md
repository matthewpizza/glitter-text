# ![Glitter Text](http://cl.ly/image/27103K2u0s1j/glitter-text.gif)

ImageMagick is cool.

## Requirements

* [ImageMagick](http://www.imagemagick.org/)
	* Install with [Homebrew](http://brew.sh/) `brew install imagemagick`
* Some knowledge of the command line.

## Installation

### Fonts

On OS X, ImageMagick may not know the available system fonts. To generate a list of fonts for ImageMagick, use the [imagick_type_gen](http://www.imagemagick.org/Usage/scripts/imagick_type_gen) script, which is included in the bin directory for convenience.

Assuming a `.magick` directory exists in the current user home folder (if not, create it: `mkdir ~/.magick`), the following command will generate a list of all font files found in `/Library/Fonts`.

```bash
find /Library/Fonts -name *.ttf -o -name *.otf | \
	./bin/imagick_type_gen.pl -f - > ~/.magick/type.xml
```

### Glitter

Glitter text is a combination of two elements, text and glitter. Glitter can be created and appropriated by many means, but here are two:

* The [ImageMagick docs](http://www.imagemagick.org/Usage/anim_mods/#glitter) covers how to generate new random glitter.
* There are also a wealth of glitter and star animations in the [Star Indexes](http://www.scri8e.com/stars/).

## Usage

This is only a README for now, the basic idea though:

* Create mask image from text
```bash
convert -fill white -background none -font ComicSansMSB \
	-gravity center -pointsize 72 label:"Glitter Text" mask.gif
```

* Create tiled background large enough for text
```bash
convert background.gif -virtual-pixel tile \
	-set option:distort:viewport 450x80 -distort SRT 0 \
	tiled-background.gif
```

* Apply mask to background
```bash
convert tiled-background.gif null: mask.gif -matte \
	-compose DstIn -layers composite glitter-text.gif
```