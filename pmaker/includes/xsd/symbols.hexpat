#pragma once

namespace auto xsd {
    struct Symbols {
        u16 full [[format("xsd::format::symbol")]];
        u16 half [[format("xsd::format::symbol")]];
        u16 quarter [[format("xsd::format::symbol")]];
        u16 french_knot [[format("xsd::format::symbol")]];
        u16 petite [[format("xsd::format::symbol")]];
        u16 bead [[format("xsd::format::symbol")]];
    };

    struct SymbolSettings {
        u16 screen_spacing_y_in_pixels;
        u16 screen_spacing_x_in_pixels;
        u16 printer_spacing_x_in_pixels;
        u16 printer_spacing_y_in_pixels;

        u16 scale_using_maximum_font_width [[format("xsd::format::boolean")]];
        u16 scale_using_font_height [[format("xsd::format::boolean")]];

        u16 quarter_petite_size [[format("xsd::format::percentage")]];

        u16 allow_color_behind_symbols [[format("xsd::format::boolean")]];
        u16 use_large_half_stitch_symbol [[format("xsd::format::boolean")]];
        padding[6];

        u16 full_half_french_size [[format("xsd::format::percentage")]];

        u16 use_triangles_behind_quarter_stitches [[format("xsd::format::boolean")]];
        u16 draw_symbols_over_backstitches [[format("xsd::format::boolean")]];
        padding[2];
    };

    namespace format {
        fn symbol(u16 value) {
            return value == 0xFFFF ? "unspecified" : value;
        };
    }
}
