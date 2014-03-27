# ![Glitter Text](http://cl.ly/image/27103K2u0s1j/glitter-text.gif)

ImageMagick is cool.

## Requirements

* [ImageMagick](http://www.imagemagick.org/)
	* On OS X, install with [Homebrew](http://brew.sh/) `brew install imagemagick`
* Some knowledge of running scripts on the command line.

### Glitter

Glitter text is a combination of two elements, text and glitter. There are a handful of example glitter images included in this repo. 

New glitter can be created and appropriated by many means, but here are two:

* The [ImageMagick docs](http://www.imagemagick.org/Usage/anim_mods/#glitter) covers how to generate new random glitter.
* There are also a wealth of glitter and star animations in the [Star Indexes](http://www.scri8e.com/stars/).

## Usage

There are four arguments for the glitter text script:
* `-f` — Font name as it appears in ~/.magick/type.xml (required)
* `-s` — Font size
* `-t` — Text to glitter, wrap multiple words in quotes
* `-g` — Glitter image file

Relying on the defaults:
```bash
./glitter.sh -t "Glitter Text is Rad"
```

Using all arguments:
```bash
./glitter.sh -f ComicSansMSB -s 72 -t "Glitter Text is Rad" -g images/glitter_blue.gif
```

All images are saved into the **processed** directory.

## Notes

### Fonts

On OS X, ImageMagick may not know the available system fonts. The Glitter Text script will attempt to create this list, but if it is unable follow these steps.

To generate a list of fonts for ImageMagick, use the [imagick_type_gen](http://www.imagemagick.org/Usage/scripts/imagick_type_gen) script, which is included in the bin directory for convenience.

Assuming a `.magick` directory exists in the current user home folder (if not, create it: `mkdir ~/.magick`), the following command will generate a list of all font files found in `/Library/Fonts`.

```bash
find /Library/Fonts -name *.ttf -o -name *.otf | \
	./bin/imagick_type_gen.pl -f - > ~/.magick/type.xml
```