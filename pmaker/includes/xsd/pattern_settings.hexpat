#pragma once

import type.types.rust;

import types.cstr;

namespace auto xsd {
    usize PAGE_HEADER_AND_FOOTER_LENGTH = 119 + 1;

    struct PageMargins {
        u16 left [[format("xsd::format::page_margin")]];
        u16 right [[format("xsd::format::page_margin")]];
        u16 top [[format("xsd::format::page_margin")]];
        u16 bottom [[format("xsd::format::page_margin")]];
        u16 header [[format("xsd::format::page_margin")]];
        u16 footer [[format("xsd::format::page_margin")]];
    };

    struct PatternSettings {
        pmaker::SizedCStr<FONT_NAME_LENGTH> default_stitch_font;
        padding[20];

        // Applies to `xsd::PatternInfo.notes`.
        pmaker::SizedCStr<FONT_NAME_LENGTH> text_font;
        u16 font_size;
        u16 font_weight;
        u16 italic [[format("xsd::format::boolean")]];
        padding[10];

        u16 view [[format("xsd::format::view")]];
        u16 zoom  [[format("xsd::format::zoom")]];

        u16 show_grid [[format("xsd::format::boolean")]];
        u16 show_centering_marks [[format("xsd::format::boolean")]];
        u16 show_fabric_colors_with_symbols [[format("xsd::format::boolean")]];
        u16 gaps_between_stitches [[format("xsd::format::boolean")]];
        padding[4];
        u16 show_rulers [[format("xsd::format::boolean")]];

        // &t - pattern name
        // &n - designer
        // &1 - company
        // &2 - copyright
        // &d - datetime stamp
        // &l - left alignment
        // &c - center alignment
        // &r - right alignment
        pmaker::SizedCStr<PAGE_HEADER_AND_FOOTER_LENGTH> page_header;
        pmaker::SizedCStr<PAGE_HEADER_AND_FOOTER_LENGTH> page_footer;

        PageMargins page_margins;

        u16 show_page_numbers [[format("xsd::format::boolean")]];
        u16 show_adjacent_page_numbers [[format("xsd::format::boolean")]];
        u16 center_chart_on_pages [[format("xsd::format::boolean")]];

        padding[2];
    };

    namespace format {
        fn view(u16 view) {
            match (view) {
                (0): return "View as stitches";
                (1): return "View as symbols";
                (2): return "View as solid";
                (3): return "View information";
                (5): return "View machine emb. info";
            }
        };

        fn zoom(u16 zoom) {
            match (zoom) {
                (0): return "400%";
                (1): return "350%";
                (2): return "300%";
                (3): return "250%";
                (4): return "200%";
                (5): return "175%";
                (6): return "150%";
                (7): return "125%";
                (8): return "100%";
                (9): return "75%";
                (10): return "50%";
                (11): return "33%";
                (12): return "25%";
                (13): return "10%";
            }
        };

        fn page_margin(u16 margin) {
            return std::format("{:.2f}\"", float(margin) / 100f);
        };
    }
}
