#pragma once

import type.types.rust;

import types.cstr;
import types.color;

namespace auto xsd {
    usize FONT_NAME_LENGTH = 32 + 1;
    usize FORMAT_LENGTH = 240;

    struct SymbolFormat {
        u16 use_alt_bg_color [[format("xsd::format::boolean")]];
        pmaker::Color bg_color; padding[1];
        pmaker::Color fg_color; padding[1];
    };

    struct LineFormat {
        u16 use_alt_color [[format("xsd::format::boolean")]];
        pmaker::Color color; padding[1];
        u16 style;
        u16 thickness [[format("xsd::format::points")]];
    };

    struct NodeFormat {
        u16 use_dot_style [[format("xsd::format::boolean")]];
        pmaker::Color color; padding[1];
        u16 use_alt_color [[format("xsd::format::boolean")]];
        u16 diameter [[format("xsd::format::points")]];
    };

    struct FontFormat {
        pmaker::SizedCStr<FONT_NAME_LENGTH> font_name;
        padding[2];
        u16 font_weight;
        bool italic;
        padding[11];
        u16 full_half_french_size [[format("xsd::format::percentage")]];
        u16 quarter_petite_size [[format("xsd::format::percentage")]];
    };

    struct Formats<auto palette_size> {
        SymbolFormat symbol[palette_size];
        padding[(FORMAT_LENGTH - palette_size) * 10];

        LineFormat back[palette_size];
        padding[(FORMAT_LENGTH - palette_size) * 10];

        padding[FORMAT_LENGTH * 4]; // Unknown formats.

        LineFormat special[palette_size];
        padding[(FORMAT_LENGTH - palette_size) * 10];

        LineFormat straight[palette_size];
        padding[(FORMAT_LENGTH - palette_size) * 10];

        NodeFormat french_knot[palette_size];
        padding[(FORMAT_LENGTH - palette_size) * 10];

        NodeFormat bead[palette_size];
        padding[(FORMAT_LENGTH - palette_size) * 10];

        FontFormat font[palette_size];
        padding[(FORMAT_LENGTH - palette_size) * 53];
    };
}
