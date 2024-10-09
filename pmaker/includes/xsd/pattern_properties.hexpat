#pragma once

namespace auto xsd {
    struct PatternProperties {
        u16 width;
        u16 height;

        /// Count of half, quarter and petite stitches.
        u32 small_stitches_count [[hidden]];
        /// Count of back, straight and special stitches, french knots and beads.
        u16 joints_count [[hidden]];

        u16 stitches_per_inch_x;
        u16 stitches_per_inch_y;

        /// Any change to the pattern file increments this counter.
        u32 action_counter [[hidden]];
        /// Always 0x0016. Otherwise PM throws error "Invalid floss in palette. Family ID not recognized. Floss color replaced with default color."
        u16 family_id [[hidden]];
    };
}
