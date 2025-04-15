#pragma endian little

import type.types.rust;

import pmaker.cstr;
import pmaker.color;

usize FABRIC_COLOR_NAME_LENGTH = 20 + 1;

struct FabricColor {
    padding[4];
    pmaker::SizedCStr<FABRIC_COLOR_NAME_LENGTH> color_name;
    pmaker::Color color;
};

u16 count @ 0x04 [[hidden]];
FabricColor fabric_colors[count] @ 0x07;
