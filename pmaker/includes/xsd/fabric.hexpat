#pragma once

import type.types.rust;

import pmaker.types.cstr;
import pmaker.types.color;

namespace auto xsd {
    usize FABRIC_COLOR_NAME_LENGTH = 40 + 1;
    usize FABRIC_KIND_NAME_LENGTH = 30 + 1;

    struct Fabric {
        pmaker::SizedCStr<FABRIC_COLOR_NAME_LENGTH> color_name;
        pmaker::Color color;
    };
}
