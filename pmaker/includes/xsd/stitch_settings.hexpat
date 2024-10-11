#pragma once

import types.color;

namespace auto xsd {
    // Yes, there is no option for a french knot.
    // If you specify it in the PM, you will not see any changes in the view.
    struct StitchStrands {
        u16 full;
        u16 half;
        u16 quarter;
        u16 back;
        u16 petite;
        u16 special;
        u16 straight;
    };

    struct DisplayThickness {
        u16 strands1;
        u16 strands2;
        u16 strands3;
        u16 strands4;
        u16 strands5;
        u16 strands6;
        u16 strands7;
        u16 strands8;
        u16 strands9;
        u16 strands10;
        u16 strands11;
        u16 strands12;
        u16 french_knot;
    };

    struct StitchSettings {
        StitchStrands default_strands;
        DisplayThickness display_thicknesses;

        u16 outlined [[format("xsd::format::boolean")]];
        u16 use_specified_color [[format("xsd::format::boolean")]];
        u16 color_percentage [[format("xsd::format::percentage")]];
        pmaker::Color specified_color; padding[1];
        u16 outline_thickness [[format("xsd::format::points")]];
    };
}
