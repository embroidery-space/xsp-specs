#pragma once

import type.types.rust;

import types.cstr;

namespace auto xsd {
    usize FILE_PATH_LENGTH = 259 + 1;
    usize HOOP_SIZE_TEXT_LENGTH = 60 + 1;

    struct HoopColor {
        u8 brand [[format("xsd::format::brand")]];
        pmaker::SizedCStr<COLOR_NUMBER_LENGTH> number;
    };

    struct MEStitchThickness {
        u8 strands_1;
        u8 strands_2;
        u8 strands_3;
        u8 strands_4_or_more;
    };

    struct MachineExport {
        padding[2];
        u8 file_format [[format("xsd::format::me_file_format")]];
        padding[2];

        u16 hoop_width [[format("xsd::format::me_hoop_size")]];
        u16 hoop_height [[format("xsd::format::me_hoop_size")]];
        pmaker::SizedCStr<HOOP_SIZE_TEXT_LENGTH> hoop_size_text;

        MEStitchThickness full_half_quarter_stitch_thickness;
        MEStitchThickness back_stitch__thickness;

        bool show_hoop_boundrary;

        pmaker::SizedCStr<FILE_PATH_LENGTH> file_path;

        u8 amount_of_hoop_to_leave [[format("xsd::format::percentage")]];
        bool provide_alignment_stitches;
        if (provide_alignment_stitches) {
            u8 color_option [[format("xsd::format::me_hoop_color")]];
            if (bool(color_option)) {
                HoopColor hoop_color;
            } else { padding[12]; }
        } else { padding[13]; }


        u16 french_knot_diameter [[format("xsd::format::percentage")]];
        u16 french_knot_thickness [[format("xsd::format::points")]];
    };

    namespace format {
        fn me_file_format(u8 id) {
            match (id) {
                (0x00): return "Brother/Baby Lock/Bernina (*.pes)";
                (0x01): return "Brother/Baby Lock/Bernina (*.pec)";
                (0x09): return "Compucon/Singer PSW (*.xxx)";
                (0x0E): return "Elna XPressive (*.emd)";
                (0x06): return "Janome New Home (*.sew)";
                (0x0C): return "Janome Customizer 10000 (*.jef)";
                (0x0B): return "Melco (*.exp)";
                (0x03): return "Pfaff (*.pcs)";
                (0x07): return "Poem/Singer EU (*.csd)";
                (0x0A): return "Tajima (*.dst)";
                (0x02): return "Viking Husqvarna (*.hus)";
                (0x0D): return "Viking Husqvarna (*.vip)";
                (0x08): return "Viking Husqvarna (Old-style CSD) (*.csd)";
            }
        };

        fn me_hoop_size(u16 hoop_size) {
            float millimetres = float(hoop_size) / 10f;
            float inches = millimetres / (254f / 10f);
            return std::format("{:.0f} mm ({:.1f}\")", millimetres, inches);
        };

        fn me_hoop_color(u8 option) {
            return bool(option) ? "Use specified palette": "<use current color>";
        };
    }
}
