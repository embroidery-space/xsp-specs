#pragma endian little
#pragma description XSPro Palette Pattern

import type.types.rust;

import xsp.cstr;
import xsp.color;

usize COLOR_NUMBER_LENGTH = 28 + 1;

struct PaletteItem {
    xsp::SizedCStr<COLOR_NUMBER_LENGTH> number;
    xsp::Color color [[color("000000")]];
} [[color(std::format("{:02X}{:02X}{:02X}", color.r, color.g, color.b))]];

u16 size @ 0x1D [[hidden]];
PaletteItem palette[size] @ 0x1F;
