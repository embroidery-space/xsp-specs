#pragma once

namespace auto xsd {
    struct PageSetup {
        u16 print_chart [[format("xsd::format::boolean")]]; padding[2];
        u16 print_information [[format("xsd::format::boolean")]];

        u16 show_floss_colors [[format("xsd::format::boolean")]];
        u16 show_floss_usage [[format("xsd::format::boolean")]];
        u16 sort_floss_list [[format("xsd::format::boolean")]];

        u16 printed_chart_size [[format("xsd::format::printed_chart_size")]];

        if (printed_chart_size == 1) {
            u16 pages_across;
            u16 pages_down;
        } else { padding[4]; }

        padding[2];
        u16 show_page_overlapping [[format("xsd::format::boolean")]];
        u16 show_centering_marks [[format("xsd::format::boolean")]];
        u16 show_grid_numbers [[format("xsd::format::boolean")]];

        if (printed_chart_size == 2) {
            u16 spi [[format("xsd::format::page_setup_spi")]];
        } else { padding[2]; }
    };

    namespace format {
        fn printed_chart_size(u16 size) {
            match (size) {
                (0): return "Same as display size";
                (1): return "Span printing over specified number of pages";
                (2): return "Size using specified stitch size";
                (3): return "Fit to one page";
            }
        };

        fn page_setup_spi(u16 spi) {
            return std::format("{:.1f}", float(spi) / 1000f);
        };
    }
}
