# XSD Specification

XSD is a proprietary cross-stitch file format used by the _[Pattern Maker for Cross Stitch](https://web.archive.org/web/20191127080612/http://hobbyware.com)_.
It is a binary format with quite a weird structure and compressed stitches data.
Its structure is described in hex patterns using [ImHex](https://github.com/WerWolv/ImHex)'s syntax.
We are learning more about this format through reverse engineering.

**If you know a bit more, please tell us!**
Open a pull request on GitHub or contact the author via [email](mailto:nazarantoniuk18@gmail.com).

> [!IMPORTANT]
> To run the `xsd.hexpat`, you must create a symlink in the ImHex's `includes` folder titled `pmaker` or copy-paste the content from `pmaker/includes/` there.
