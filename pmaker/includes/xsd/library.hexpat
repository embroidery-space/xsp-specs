#pragma once

import type.types.rust;

import pmaker.types.cstr;

namespace auto xsd {
    usize CELLS_NUMBER = 100;
    usize CELL_KEYWORDS_NUMBER = 5;
    usize CELL_NAME_LENGTH = 50 + 1;
    usize CELL_KEYWORD_LENGTH = 20 + 1;

    struct CellBoundaries {
        u16 start_x;
        u16 start_y;
        u16 end_x;
        u16 end_y;
    };

    struct Cell {
        pmaker::SizedCStr<CELL_NAME_LENGTH> name;
        CellBoundaries boundaries;
    };

    struct LibraryFontOptions {
        u16 baseline_position;
        u16 default_line_spacing;
        u16 font_size;
    };

    struct CellKeyword {
        pmaker::SizedCStr<CELL_KEYWORD_LENGTH> keyword;
    } [[inline]];

    struct CellKeywords {
        CellKeyword keywords[CELL_KEYWORDS_NUMBER] [[inline]];
    };

    struct Library {
        u16 type;
        u16 cell_size_x;
        u16 cell_size_y;
        Cell cells[CELLS_NUMBER];
        LibraryFontOptions library_font_options;
        CellKeywords cell_keywords[CELLS_NUMBER];
    };
}
