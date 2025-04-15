#pragma once

import std.io;
import std.string;

namespace auto pmaker {
    struct SizedCStr<auto length> {
        char data[while(std::mem::read_unsigned($, 1) != 0x00)];
        padding[length - std::string::length(data)];
    } [[sealed, format("pmaker::format::cstr")]];

    namespace format {
        fn cstr(ref auto cstr) {
            return std::format("{}", cstr.data);
        };
    }
}
