#pragma endian little

import type.types.rust;

import pmaker.types.cstr;

usize VENDOR_NAME_LENGTH = 259 + 1;
usize GROUP_NAME_LENGTH = 259 + 1;
usize BRAND_NAME_LENGTH = 39 + 1;
usize BRAND_SHORT_NAME_LENGTH = 11 + 1;

struct Brand {
    pmaker::xsd::SizedCStr<VENDOR_NAME_LENGTH> vendor;
    pmaker::xsd::SizedCStr<GROUP_NAME_LENGTH> group;
    pmaker::xsd::SizedCStr<BRAND_NAME_LENGTH> brand;
    pmaker::xsd::SizedCStr<BRAND_SHORT_NAME_LENGTH> short_name;
    u16 id;
};

u16 count @ 0x00 [[hidden]];
Brand color_brand_list[count] @ 0x04;
