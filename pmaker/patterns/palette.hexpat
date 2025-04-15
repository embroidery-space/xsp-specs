#pragma magic [?? ?? ?? ??] @ 0x00
#pragma endian little
#pragma description Pattern Maker Palette

import hex.provider;
import type.types.rust;

import pmaker.cstr;
import pmaker.color;

usize COLOR_NUMBER_LENGTH = 10 + 1;
usize COLOR_NAME_LENGTH = 40 + 1;
usize BLENDS_NUMBER = 4; // PM limits blends up to 4 colors. The minimum is 2 if they are present.

struct Blend {
    u8 brand;
    pmaker::SizedCStr<COLOR_NUMBER_LENGTH> number;
};

struct Bead {
    u16 length [[format("format_millimetres")]];
    u16 diameter [[format("format_millimetres")]];
};

struct PaletteItem {
    padding[2];

    u8 brand;
    pmaker::SizedCStr<COLOR_NUMBER_LENGTH> number;
    pmaker::SizedCStr<COLOR_NAME_LENGTH> name;
    pmaker::Color color;
    bool is_not_available [[hidden]];

    u16 blends_count [[hidden]];
    u8 blends_to_skip = BLENDS_NUMBER - blends_count;
    Blend blends[blends_count];
    padding[blends_to_skip * 12]; // Skip empty blends.
    u8 blend_strands[blends_count];
    padding[blends_to_skip]; // Skip empty blend strands.

    u32 is_bead [[hidden]];
    if (bool(is_bead)) { Bead bead; }
    else { padding[4]; }

    padding[2];
};

fn get_palette_offset() {
    match (hex::prv::get_information("file_extension")) {
        (".Master"): return 0x08;
        (".User"): return 0x06;
    }
};

u16 size @ 0x04 [[hidden]];
PaletteItem palette[size] @ get_palette_offset();
