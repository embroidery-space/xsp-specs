#pragma magic [?? ?? ?? ??] @ 0x00
#pragma endian little

import hex.provider;

import xsd.palette;

fn palette_offset() {
    match (hex::prv::get_information("file_extension")) {
        (".Master"): return 0x08;
        (".User"): return 0x06;
    }
};

u16 size @ 0x04 [[hidden]];
xsd::PaletteItem palette[size] @ palette_offset();
