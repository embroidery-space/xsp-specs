# Pattern Maker Resources

> [!IMPORTANT]
> To use the `.hexpat` pattern, configure the [ImHex](https://github.com/WerWolv/ImHex).
>
> First, open ImHex settings (_Extras_ -> _Settings_, or use `Ctrl+,` shortcuts) and go to the _Folders_ tab.
> Then, click the _Add new folder_ button and select the `pmaker/includes/` folder.
> This will allow ImHex to connect our custom resources and use them in hex patterns.
>
> Now, you can open a file you want to view in ImHex.
> To import a hex pattern, open pattern browser (_File_ -> _Import_ -> _Pattern File_) and select the desired hex pattern file.

## XSD

XSD is a proprietary cross-stitch file format used by the _[Pattern Maker for Cross Stitch](https://web.archive.org/web/20191127080612/http://hobbyware.com)_.
It is a binary format with quite a weird structure and compressed stitches data.

See [`xsd.hexpat`](./patterns/xsd.hexpat) to examine the XSD patterns structure.

## Palette

Pattern Maker stores color palettes in `.Master` and `.User` files (original and custom, respectively).

See [`palette.hexpat`](./patterns/palette.hexpat) to examine the structure of color palettes.

## Color Brand and Fabric Color Lists

Pattern Maker stores a list of supported color palettes in the `Color_Brand_List` file and fabric colors in the `Fabric_Colors` file.

See [`Color_Brand_List.hexpat`](./patterns/Color_Brand_List.hexpat) and [`Fabric_Colors.hexpat`](./patterns/Fabric_Colors.hexpat) to examine their structures.
