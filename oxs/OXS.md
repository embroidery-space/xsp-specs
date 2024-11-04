# Open Cross-Stitch

The Open Cross-Stitch file format uses XML to record the data.

## `chart`

The file itself begins with an encompassing element called `chart`.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<chart>
  <!-- content -->
</chart>
```

Within a chart, there are several sections:

| Section Name                    | Required |
| ------------------------------- | -------- |
| `format`                        | No       |
| `properties`                    | Yes      |
| `palette`                       | No       |
| `fullstitches`                  | Yes      |
| `partstitches`                  | No       |
| `backstitches`                  | Yes      |
| `ornaments_inc_knots_and_beads` | No       |
| `commentboxes`                  | No       |

> `properties`, `fullstitches`, and `backstitches` elements should be considered mandatory, even if they are empty.

### `format`

The first section is purely informational - just a brief format description.

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

### `properties` (occurs once)

Defines general pattern properties (all are optional).

| Property            | Type    |
| ------------------- | ------- |
| `oxsversion`        | string  |
| `software`          | string  |
| `software_version`  | string  |
| `chartheight`       | integer |
| `chartwidth`        | integer |
| `charttitle`        | string  |
| `author`            | string  |
| `copyright`         | string  |
| `instructions`      | string  |
| `stitchesperinch`   | number  |
| `stitchesperinch_y` | number  |
| `palettecount`      | integer |

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
  custom-property1="value1"
  custom-property2="value2"
/>
```

### `palette` (occurs once)

This element holds n `palette_item` entries, one per colour in the palette.
The `palette_item` entry with index 0 always defines the cloth colour.

The `properties.palettecount` value may be useless because the `palette_item` elements could be counted.
If you use the `properties.palettecount` value, note the real count of `palette_item` elements is `properties.palettecount - 1`.

#### `palette_item` (occurs `properties.palettecount` times as children `palette`)

This element defines information about colour in the palette and may represent a thread, bead, or other colour item.

| Property      | Type              |
| ------------- | ----------------- |
| `index`       | integer           |
| `number`      | string            |
| `name`        | string            |
| `color`       | hex string        |
| `printcolor`  | hex string or nil |
| `blendcolor`  | hex string or nil |
| `comments`    | string            |
| `strands`     | integer           |
| `symbol`      | string or integer |
| `dashpattern` | string or integer |
| `bsstrands`   | integer           |
| `bscolor`     | hex string or nil |

```xml
<!-- The element with index 0 defines the cloth colour. -->
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
  dashpattern=""
  bsstrands="2"
  bscolor="FFFFFF"
  custom-property="value"
/>

<palette_item
  index="1"
  number="DMC    310"
  name="Black"
  color="2C3225"
  printcolor="FFFFFF"
  blendcolor="nil"
  comments=""
  strands="2"
  symbol="100"
  dashpattern=""
  bsstrands="1"
  bscolor="2C3225"
  custom-property="value"
/>
```

### `fullstitches` (occurs once)

This element holds n `stitch` entries.

#### `stitch` (occurs n times as children of `fullstitches`)

Only actual stitches should be recorded.
There is no need to store empty stitches.
If you do so anyway, the bare cloth is `palette_item` with the index 0.

| Property   | Type    |
| ---------- | ------- |
| `x`        | integer |
| `y`        | integer |
| `palindex` | integer |

```xml
<stitch x="1" y="47" palindex="3" />
<stitch x="1" y="48" palindex="3" />
<stitch x="1" y="49" palindex="3" marked="true" />
```

### `partstitches` (occurs once)

This element holds n `partstitch` entries.

#### `partstitch` (occurs n times as children of `partstitches`)

As in the case of full stitches, only actual stitches should be recorded.

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
