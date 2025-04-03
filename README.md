# Cross-Stitch Pattern Specifications

This repository contains specifications for the cross-stitch pattern file formats supported by the [Embroidery Studio](https://github.com/embroidery-space/embroidery-studio).

## Orientation

```text
oxs/ # Everything related to the Open Cross-Stitch file format.
pmaker/ # Everything related to the Pattern Maker resources (patterns, colour palettes, etc.).
├── includes/ # A module set that encapsulates related or utility types.
│   ├── types/ # Utility types.
│   └── xsd/ # XSD components.
├── Color_Brand_List.hexpat # Describes the structure of the color brand list.
├── palette.hexpat # Describes the structure of colour palettes used by PM (.Master or .User).
└── xsd.hexpat # Describes the structure of XSD patterns.
```
