# Open Cross-Stitch

The Open Cross-Stitch file format uses XML to store the data.

## `chart`

The file itself begins with an encompassing element called `chart`.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<chart>
  <!-- content -->
</chart>
```

This is the only element required for parsing the pattern.
If the file does not contain the `chart` tag, an error should be returned.

It is also recommended to check that the file contains a closing `chart` tag.
That is, we expect the parsing of the pattern to be completed at the closing `chart` tag, not at EOF.

Below is a description of typical sections and their elements that are common in patterns.

### `format`

The first section is optional and is purely informational - just a brief format description.

```xml
<format
  comments01="Designed to allow interchange of basic pattern data between any cross stitch style software"
  comments02="the 'properties' section establishes size, copyright, authorship and software used"
  comments03="The features of each software package varies, but using XML each can pick out the things it can deal with, while ignoring others"
  comments04="The basic items are :"
  comments05="'palette'..a set of colors used in the design: palettecount excludes cloth color, which is item 0"
  comments06="'fullstitches'.. simple crosses"
  comments07="'backstitches'.. lines/objects with a start and end point"
  comments08="(There is a wide variety of ways of treating part stitches, knots, beads and so on.)"
  comments09="Colors are expressed in hex RGB format."
  comments10="Decimal numbers use US/UK format where '.' is the indicator - eg 0.5 is 'half'"
  comments11="For readability, please use words not enumerations"
  comments12="The properties, fullstitches, and backstitches elements should be considered mandatory, even if empty"
  comments13="element and attribute names are always lowercase"
/>
```

### `properties`

This section is optional and defines general pattern properties.
It is recommended to keep this section at the top of the file, as it can be used as a reference for parsing the pattern file.

- `oxsversion`: string - The version of the OXS specification.
  If not specified, we assume that the latest OXS version is used (currently, `1.0`).
- `software`: string - Specifies the software used to write the pattern file.
  Can be used to indicate app-specific elements and attributes.
- `software_version`: string - Specifies the software version used to write the pattern file.
  Can be used to indicate app/version-specific elements and attributes.
- `chartheight`: integer - Defaults to `100`.
- `chartwidth`: integer - Defaults to `100`.
- `charttitle`: string
- `author`: string
- `copyright`: string
- `instructions`: string
- `stitchesperinch`: number - Specifies the number of stitches per inch of cloth/fabric.
- `stitchesperinch_y`: number - Same as `stitchesperinch`, but for vertical axis.
  Can be used for non-square cloth/fabric.
  If not specified, the value from `stitchesperinch` should be used.
- `palettecount`: integer - The number of palette colors other than cloth/fabric.

All of these attributes are optional.
However, we recommend that you specify at least `oxsversion` for consistency, and `chartwidth` and `chartheight` for correct display.

If some of the attributes are not specified but are required by a particular software, they should be replaced by the default value of that software.

```xml
<properties
  oxsversion="1.0"
  software="Ursa Software"
  software_version="2021"
  chartheight="73"
  chartwidth="69"
  charttitle="Piggies"
  author="Unknown"
  copyright="by Ursa Software"
  instructions="Enjoy the embroidery process!"
  stitchesperinch="14"
  stitchesperinch_y="14"
  palettecount="7"
/>
```

### `palette`

This section is optional and holds `palette_item` elements.

The `palette_item` element with index `0` (usually, the first one in the palette) always defines the cloth/fabric color.
If the `index` attribute is not specified, the first `palette_item` in the palette is assumed to define the cloth/fabric color.

During parsing, you can use `properties.palettecount`, if specified, to properly handle the `palette`.
However, the only source of truth about a palette is the `palette` itself.

If the `palette` tag is missing or empty, than we consider the palette to be empty.

Note that the size of the palette is not restricted and can contain any number of `palette_item`s.

#### `palette_item`

Defines color information in the palette and can represent a thread, bead, or any other material color.

- `index`: integer
- `number`: string - Specifies both the color brand and the color number (for example, `DMC 310`).

  In Ursa, they are separated by four spaces.
  In other programs, they can be separated by a single space.

  In any case, the last part of the string splitted by a space should be considered the number (we expect the number to be a solid string), and everything before it should be considered the brand.

- `name`: string
- `color`: hex string - Defaults to `FFFFFF` (white) for cloth/fabric and `FF00FF` (magenta) for materials.
- `printcolor`: hex string or `nil`
- `blendcolor`: hex string or `nil`
- `comments`: string
- `strands`: integer
- `symbol`: integer or string - Specifies the symbol used to graphically represent the color.
  It can be a decimal number representing a UTF-8 [code point](https://developer.mozilla.org/en-US/docs/Glossary/Code_point) or a string representing the actual character.
- `symbol_courier` _by MiniStitch (UrsaSoftware_): string - Specifies the actual symbol character (for example, `A`).
- `bsstrands`: integer
- `bscolor`: hex string or `nil`
- `fontname` _by XSPro Platinum (DP Software)_: string - Specifies the font family (for example, `Cross Stitch Pro Platinum`) used to draw symbols of this color.

All of these attributes except `color` are optional.
If the `color` attribute is missing, the application should replace it with the default color (see notes above) and notify the user about it so that they can fix the issue later.

```xml
<!-- The element with index 0 defines the cloth/fabric color. -->
<palette_item
  index="0"
  number="cloth"
  name="cloth"
  color="FFFFFF"
  printcolor="FFFFFF"
  blendcolor="nil"
  comments=""
  strands="2"
  symbol="100"
  bsstrands="2"
  bscolor="FFFFFF"
/>

<!-- Other elements define the material colors. -->
<palette_item
  index="1"
  number="DMC    310"
  name="Black"
  color="2C3225"
  printcolor="000000"
  blendcolor="nil"
  comments=""
  strands="2"
  symbol="100"
  bsstrands="1"
  bscolor="2C3225"
/>
```

### `fullstitches`

Holds `stitch` elements.

#### `stitch`

Defines full stitch information.

> Only actual stitches should be stored.
> There is no need to store empty stitches.

| Property   | Type    |
| ---------- | ------- |
| `x`        | integer |
| `y`        | integer |
| `palindex` | integer |
| `marked`   | boolean |

```xml
<!-- This stitch is "empty" because it uses the cloth color. -->
<stitch x="1" y="47" palindex="0" />

<stitch x="1" y="47" palindex="1" />
<stitch x="1" y="48" palindex="2" />
<stitch x="1" y="49" palindex="3" marked="true" />
```

### `partstitches`

Holds `partstitch` elements.

#### `partstitch`

Defines part stitch information.

> As in the case of full stitches, only actual stitches should be stored.

| Property    | Type    | Note                |
| ----------- | ------- | ------------------- |
| `x`         | integer |                     |
| `y`         | integer |                     |
| `palindex1` | integer | Colour on the left  |
| `palindex2` | integer | Colour on the right |
| `direction` | integer |                     |

When the direction 1, the result is bottom-left for the `palindex1` and top-right for the `palindex2`.
When the direction 2, the result is top-left for the `palindex1` and bottom-right for the `palindex2`.
In both cases, the stitch is always in the forward direction.

When the direction 3, the result is `/` (forward).
When the direction 4, the result is `\` (backward).
In these cases, the stitch is considered to be the Gobelin stitch.

```xml
<partstitch x="10" y="30" palindex1="7" palindex2="0" direction="2" />
<partstitch x="11" y="43" palindex1="5" palindex2="0" direction="1" />
<partstitch x="11" y="43" palindex1="7" palindex2="0" direction="2" />
```

### `backstitches` (occurs once)

This element holds n `backstitch` entries.

#### `backstitch` (occurs n times as children of `backstitches`)

| Property     | Type    |
| ------------ | ------- |
| `x1`         | number  |
| `y1`         | number  |
| `x2`         | number  |
| `y2`         | number  |
| `palindex`   | integer |
| `objecttype` | string  |
| `sequence`   | integer |

```xml
<backstitch x1="68" x2="68" y1="62" y2="63" palindex="3" objecttype="backstitch" sequence="0" />
<backstitch x1="32" x2="31" y1="7" y2="7" palindex="1" objecttype="daisy" sequence="0"/>
<backstitch x1="27.5" x2="36" y1="11.5" y2="10" palindex="1" objecttype="bugle" sequence="0"/>
```

### `ornaments_inc_knots_and_beads` (occurs once)

This element holds n `object` entries.

#### `object` (occurs n times as children of `ornaments_inc_knots_and_beads`)

The `object` entry describes anything that can be added by different software.

| Property     | Type    |
| ------------ | ------- |
| `x1`         | number  |
| `y1`         | number  |
| `palindex`   | integer |
| `objecttype` | string  |

```xml
<object x1="2" y1="3.5" palindex="1" objecttype="fullcross"/>
<object x1="5" y1="6.5" palindex="1" objecttype="4x4"/>
<object x1="8" y1="12" palindex="1" objecttype="minikey"/>
```

<details>
<summary>UrsaSoftware's list of object</summary>

In a file created by Ursa Software's MacStitch or WinStitch applications, the current possible values of "object type" are as follows: all have a location, and the object type determines the size and shape.
Other software suppliers will have different object types that are not on this list.

- `knot` - a french knot
- `bead` - a simple bead of about 2.5 mm
- `quarter` - a quarter stitch
- `verticalhalf` - a half stitch which is taller than it is wide - half the width of a cross
- `horizontalhalf` - a half stitch which is wider than it is tall - half the height of a cross
- `fullcross` - a normal cross stitch, but placed anywhere
- `3x2` - a cross stitch, but 1.5 times wider than a normal one
- `2x3` - a cross stitch, but 1.5 times taller than a normal one
- `3x3”`- a cross stitch, but 1.5 times taller and wider than a normal one
- `4x4` - a cross stitch, but 2 times taller and wider than a normal one
- `minikey` - a color blob or symbol plus the thread number
- `4x2` - a stitch, but 2 times wider than a normal one, used for knitting
- `6x2` - a stitch, but 3 times wider than a normal one, used for knitting
- `8x2`- a stitch, but 4 times wider than a normal one, used for knitting
- `10x2` - a stitch, but 5 times wider than a normal one, used for knitting
- `12x2` - a stitch, but 6 times wider than a normal one, used for knitting
- `14x2` - a stitch, but 7 times wider than a normal one, used for knitting
- `16x2` - a stitch, but 8 times wider than a normal one, used for knitting
- `bead2mm` - a 2mm bead
- `bead3mm` - a 3mm bead
- `bead5mm` - a 5mm bead
- `bead6mm`
- `bead8mm`
- `bead10mm`
- `bead12mm`
- `button6mm`
- `button12mm` - buttons
- `button8mm`
- `button10mm`
- `button20mm`
- `sequin6mm`
- `topleftlongtriangle` - a triangle 1 wide, 2 tall, at top left corner
- `toprightlongtriangle` - a triangle 1 wide, 2 tall, at top right corner
- `botleftlongtriangle` - a triangle 1 wide, 2 tall, at bottom left corner
- `botrightlongtriangle` - a triangle 1 wide, 2 tall, at bottom right corner
- `topleftwidetriangle` - a triangle 2 wide, 1 tall, at top left corner
- `toprightwidetriangle` - a triangle 2 wide, 1 tall, at top right corner
- `botleftwidetriangle` - a triangle 2 wide, 1 tall, at bottom left corner
- `botrightwidetriangle` - a triangle 2 wide, 1 tall, at bottom right corner
- `queen2x2` - a diamond shape , width 2 normal stitches
- `queen3x3` - a diamond shape , width 3 normal stitches
- `queen4x4` - a diamond shape , width 4 normal stitches
- `queen5x5` - a diamond shape , width 5 normal stitches

</details>

### `commentboxes` (occurs once)

This element holds n `commentbox` entries.

#### `commentbox` (occurs n times as children of `commentboxes`)

| Property    | Type    |
| ----------- | ------- |
| `boxwidth`  | integer |
| `boxheight` | integer |
| `boxleft`   | integer |
| `boxtop`    | integer |
| `boxwords`  | string  |

```xml
<commentbox boxheight="2" boxwidth="34" boxleft="18" boxtop="3" boxwords="This is a comment" />
```
