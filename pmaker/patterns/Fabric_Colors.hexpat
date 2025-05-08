#pragma endian little
#pragma description Pattern Maker Fabric Colors

import type.types.rust;

import xsp.cstr;
import xsp.color;

usize FABRIC_COLOR_NAME_LENGTH = 20 + 1;

struct FabricColor {
    padding[4];
    xsp::SizedCStr<FABRIC_COLOR_NAME_LENGTH> color_name;
    xsp::Color color;
};

u16 count @ 0x04 [[hidden]];
FabricColor fabric_colors[count] @ 0x07;
