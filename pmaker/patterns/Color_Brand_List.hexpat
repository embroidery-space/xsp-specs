#pragma endian little
#pragma description Pattern Maker Color Brand List

import type.types.rust;

import xsp.cstr;

usize VENDOR_NAME_LENGTH = 259 + 1;
usize GROUP_NAME_LENGTH = 259 + 1;
usize BRAND_NAME_LENGTH = 39 + 1;
usize BRAND_SHORT_NAME_LENGTH = 11 + 1;

struct Brand {
    xsp::SizedCStr<VENDOR_NAME_LENGTH> vendor;
    xsp::SizedCStr<GROUP_NAME_LENGTH> group;
    xsp::SizedCStr<BRAND_NAME_LENGTH> brand;
    xsp::SizedCStr<BRAND_SHORT_NAME_LENGTH> short_name;
    u16 id;
};

u16 count @ 0x00 [[hidden]];
Brand color_brand_list[count] @ 0x04;
