#pragma once

import std.io;

namespace auto xsp {
    struct Color {
        u8 r;
        u8 g;
        u8 b;
    } [[sealed, format("xsp::format::color"), color(std::format("{:02X}{:02X}{:02X}", r, g, b))]];

    namespace format {
        fn color(ref Color color) {
            return std::format("#{:02X}{:02X}{:02X}", color.r, color.g, color.b);
        };
    }
}
