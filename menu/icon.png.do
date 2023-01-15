#!/bin/sh
set -eu

SVG_FILE=${2%.png}.svg

# How crisp a Minetest menu icon appears is influenced by image height
# and width. Low resolutions lead to blurry edges, as Minetest scales
# menu icons up. High resolutions lead to jagged edges, as Minetest
# scales menu icons down. Height & width of 72 pixes seem to work.
#
# Though usually one would export directly to "${3}", Inkscape 1.0 had
# its command line options changed by people who apparently think that
# backwards compatibility is some kind of swear word: Whereas earlier
# Inkscape versions would export to a file called foo.png.tmp, newer
# behaviour is to ignore the user's wishes & write to foo.png.png –
# unless one asks it to write to a filename with a .png extension,
# Inkscape 1.0 changes the filename extension to .png each time.
#
# As we do not know the extension of "${3}", we have to use the
# extension, then rename the resulting file to the proper name;
# only that way the export works with Inkscape 1.0 & earlier …
>&2 inkscape \
	--file="${SVG_FILE}" \
	--export-png="${3}".png \
	--export-area-page \
	--export-height 72 \
	--export-width 72 \

mv "${3}".png "${3}"
