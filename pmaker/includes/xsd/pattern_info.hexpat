#pragma once

import type.types.rust;

import types.cstr;

namespace auto xsd {
    usize PATTERN_NAME_LENGTH = 40 + 1;
    usize AUTHOR_NAME_LENGTH = 40 + 1;
    usize COMPANY_NAME_LENGTH = 40 + 1;
    usize COPYRIGHT_LENGTH = 200 + 1;
    usize PATTERN_NOTES_LENGTH = 2048 + 1;

    struct PatternInfo {
        pmaker::SizedCStr<PATTERN_NAME_LENGTH> name;
        pmaker::SizedCStr<AUTHOR_NAME_LENGTH> author;
        pmaker::SizedCStr<COMPANY_NAME_LENGTH> company;
        pmaker::SizedCStr<COPYRIGHT_LENGTH> copyright;
        pmaker::SizedCStr<PATTERN_NOTES_LENGTH> notes;
        u16 additional_fabric_count_sizes[3];
        pmaker::SizedCStr<FABRIC_KIND_NAME_LENGTH> fabric_kind;
    };
}
