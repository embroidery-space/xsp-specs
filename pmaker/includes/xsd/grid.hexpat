#pragma once

import std.io;

import types.color;

namespace auto xsd {
    struct GridLineStyle {
        u16 thickness [[format("xsd::format::grid_line_thickhness")]]; padding[2];
        pmaker::Color color; padding[3];
    };

    struct GridOptions {
        u16 major_grid_line_every_stitches;
        padding[2];
        GridLineStyle minor_screen_lines;
        GridLineStyle major_screen_lines;
        GridLineStyle minor_print_lines;
        GridLineStyle major_print_lines;
        padding[12];
    };

    namespace format {
        fn grid_line_thickhness(u16 thickness) {
            // return std::format("{:.3f}\"" , float(thickness) / 1000f;
            // Or it is better to convert from pt to cm and mm.
            // return std::format("{:.3f} cm" , float(thickness) * (26f / 10000f);
            // return std::format("{:.3f} mm" , float(thickness) * (254f / 10000f);
            return std::format("{:.3f} pt" , float(thickness) * (72f / 1000f));
        };
    }
}
