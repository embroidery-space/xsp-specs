#pragma once

import std.io;
import std.string;
import type.types.rust;

import xsd.utils;
import pmaker.types.cstr;
import pmaker.types.color;

namespace auto xsd {
    usize COLOR_NUMBER_LENGTH = 10 + 1;
    usize COLOR_NAME_LENGTH = 40 + 1;
    usize BLENDS_NUMBER = 4; // PM limits blends up to 4 colors. The minimum is 2.

    struct Blend {
        u8 brand [[format("xsd::format::brand")]];
        pmaker::SizedCStr<COLOR_NUMBER_LENGTH> number;
    };

    struct PaletteItem {
        padding[2];

        u8 brand [[format("xsd::format::brand")]];
        pmaker::SizedCStr<COLOR_NUMBER_LENGTH> number;
        pmaker::SizedCStr<COLOR_NAME_LENGTH> name;
        pmaker::Color color;
        bool is_not_available [[hidden]];

        u16 blends_count [[hidden]];
        u8 blends_to_skip = BLENDS_NUMBER - blends_count;
        Blend blends[blends_count];
        padding[blends_to_skip * 12]; // Skip empty blends.
        u8 blend_strands[blends_count];
        padding[blends_to_skip]; // Skip empty blend strands.

        u32 is_bead [[hidden]];
        if (is_bead == 1) {
            u16 bead_length [[format("xsd::format::millimetres")]];
            u16 bead_diameter [[format("xsd::format::millimetres")]];
        } else { padding[4]; }

        padding[2];
    };

    struct Note {
        u16 length [[hidden]];
        pmaker::SizedCStr<length> data;
    } [[sealed, format("xsd::format::note")]];

    struct PINotes {
        Note full;
        Note half;
        Note quarter;
        Note back;
        Note french_knot;
        Note straight;
        Note special;
        Note petite;
        Note bead;
    };

    struct PIStrands {
        u16 full [[format("xsd::format::strands")]];
        u16 half [[format("xsd::format::strands")]];
        u16 quarter [[format("xsd::format::strands")]];
        u16 back [[format("xsd::format::strands")]];
        u16 french_knot [[format("xsd::format::strands")]];
        u16 petite [[format("xsd::format::strands")]];
        u16 special [[format("xsd::format::strands")]];
        u16 straight [[format("xsd::format::strands")]];
    };

    struct Palette {
        u16 size [[hidden]];
        PaletteItem items[size];
        u16 positions[size];
        PINotes notes[size];
        PIStrands strands[size];
    };

    namespace format {
        fn note(ref Note note) {
            return std::format("{}", note.data);
        };

        fn strands(u16 strands) {
            return strands == 0 ? "default" : strands;
        };

        fn brand(u8 id) {
            match (id) {
                (1): return "Anchor";
                (89): return "Anchor Marlitt";
                (103): return "Appleton Crewel Wool";
                (104): return "Appleton Tapestry Wool";
                (66): return "ARC Polyester";
                (67): return "ARC Rayon";
                (68): return "ARC Mon-Rex Metallic";
                (69): return "ARC Aurora Iridescent";
                (142): return "Ariadna Mouline";
                (31): return "Au Ver A Soie; Soie d'Alger";
                (138): return "Balerina Mouline";
                (8): return "Brother; Satin";
                (80): return "Brother; Country";
                (119): return "Carrie's Threads";
                (64): return "Caron Collection; Antica";
                (27): return "Caron Collection; Impressions; HD";
                (28): return "Caron Collection; Impressions; Solid";
                (65): return "Caron Collection; Rachel";
                (29): return "Caron Collection; Watercolours";
                (30): return "Caron Collection; Waterlilies";
                (25): return "Caron Collection; Wildflowers; HD";
                (26): return "Caron Collection; Wildflowers; Solid";
                (85): return "Coats Puppets";
                (88): return "Crescent Colours";
                (70): return "Danish Flower Thread";
                (90): return "Dinky Dyes Cotton";
                (91): return "Dinky Dies Silk";
                (0): return "DMC";
                (112): return "DMC Cebelia Crochet";
                (120): return "DMC Colbert";
                (110): return "DMC Colour Variation";
                (113): return "DMC Linen";
                (111): return "DMC Light Effects";
                (12): return "DMC Machine Embroidery";
                (107): return "DMC Medici";
                (106): return "DMC Perle Cotton";
                (63): return "DMC Rayon";
                (86): return "DMC Tapestry Wool";
                (96): return "Durak Durafix";
                (97): return "Durak Polyjet";
                (98): return "Durak Polysoft";
                (99): return "Durak Visco";
                (22): return "Eterna Silk MiniTwist";
                (59): return "Eterna Silk Silk Twist";
                (60): return "Eterna Silk Stranded";
                (108): return "Finca Mouline";
                (109): return "Finca Perle Cotton";
                (74): return "FUFU Rayon";
                (75): return "FUFU Polyester";
                (92): return "Gamma";
                (141): return "Gamma Metallic";
                (93): return "Gamma Nitka";
                (24): return "The Gentle Art; Sampler Threads";
                (43): return "The Gentle Art; Simply Shaker";
                (44): return "Ginnie Thompson Flower Thread";
                (137): return "Glissen Gloss";
                (144): return "Gloriana Silk Floss";
                (145): return "Gloriana Florimell";
                (146): return "Gloriana Tudor";
                (147): return "Gloriana Luminescence";
                (102): return "Gutermann Cotton";
                (121): return "VictoriaClayton; HDF Solid";
                (122): return "VictoriaClayton; HDF Variegated/OD";
                (62): return "Isacord";
                (100): return "Isafil";
                (101): return "Isalon";
                (10): return "Janome";
                (3): return "J&P Coats";
                (76): return "Kingstar Polyester (5K)";
                (77): return "Kingstar Polyester (1K)";
                (78): return "Kingstar Metallic";
                (124): return "Lecien Cosmo";
                (125): return "Lecien Seasons";
                (16): return "Madeira Poly Neon";
                (17): return "Madeira Rayon";
                (71): return "Marathon Metallic";
                (72): return "Marathon Polyester";
                (73): return "Marathon Rayon";
                (13): return "Mettler Silky Sheen";
                (14): return "Mettler Poly Sheen";
                (15): return "Mettler Embroidery";
                (139): return "NCT Mouline";
                (140): return "NCT Norma";
                (32): return "Needle Necessities; Empress Silk";
                (33): return "Needle Necessities; Empress Silk; OD";
                (34): return "Needle Necessities; Floss; OD";
                (35): return "Needle Necessities; French Wool; OD";
                (36): return "Needle Necessities; Madras";
                (37): return "Needle Necessities; Opalescence";
                (38): return "Needle Necessities; Pearl 5; OD";
                (39): return "Needle Necessities; Pearl 8; OD";
                (40): return "Needle Necessities; Spring II; Solid";
                (41): return "Needle Necessities; Spring II; SD";
                (42): return "Needle Necessities; Velour 18; SD";
                (115): return "Needlepaints";
                (83): return "Needlepoint Silk";
                (79): return "Olde Willow Stitchery";
                (116): return "Olympus";
                (135): return "Painters Threads; Soie d'Alger";
                (84): return "Painters Threads; Ribbon Floss Shimmer";
                (105): return "Paternayan Crewel";
                (117): return "Paternayan Persian";
                (118): return "Paternayan Rug";
                (143): return "PNK Kirova";
                (136): return "Rainbow Gallery";
                (95): return "Rainbow Gallery; Elegance";
                (94): return "Rainbow Gallery; Encore";
                (130): return "Rainbow Gallery; FyreWerks";
                (131): return "Rainbow Gallery; Fyrewerks S Sheen";
                (134): return "Rainbow Gallery; Neon Rays";
                (126): return "Rainbow Gallery; Treasure Brd Petite";
                (127): return "Rainbow Gallery; Treasure Ribbon";
                (128): return "Rainbow Gallery; Treasure Rib Petite";
                (129): return "Rainbow Gallery; Hi-Lights";
                (132): return "Rainbow Gallery; Precious Metals";
                (133): return "Rainbow Gallery; Sparkle Rays";
                (81): return "Rainbow Gallery; Splendor";
                (61): return "Robison-Anton Polyester";
                (6): return "Robison-Anton Rayon";
                (114): return "Stranded by the Sea";
                (123): return "Sullivans";
                (7): return "Sulky Rayon";
                (87): return "Thread Gatherer Silk'n Colors";
                (148): return "Thread Gatherer Flax";
                (23): return "Weeks Dye Works";
                (135): return "YLI";
                (18): return "Kreinik Blending Filament";
                (19): return "Kreinik Braid; Very Fine (#4)";
                (45): return "Kreinik Braid; Fine (#8)";
                (46): return "Kreinik Braid; Tapestry (#12)";
                (47): return "Kreinik Braid; Medium (#16)";
                (48): return "Kreinik Braid; Heavy (#32)";
                (21): return "Kreinik Cable";
                (20): return "Kreinik Cord";
                (49): return "Kreinik Ribbon; 1/8\"";
                (50): return "Kreinik Ribbon; 1/16\"";
                (51): return "Kreinik Japan; #1";
                (52): return "Kreinik Japan; #5";
                (53): return "Kreinik Japan; #7";
                (54): return "Kreinik Ombre";
                (58): return "Kreinik Silk Bella";
                (55): return "Kreinik Silk Mori";
                (56): return "Kreinik Silk Mori; Milkpaint";
                (57): return "Kreinik Silk Serica";
                (200): return "Mill Hill Glass Seed Bead";
                (201): return "Mill Hill Antique Glass Seed Bead";
                (202): return "Mill Hill Petite Glass Seed Bead";
                (203): return "Mill Hill Frosted Glass Seed Bead";
                (204): return "Mill Hill Crayon Seed Bead";
                (205): return "Mill Hill Pebble Glass Bead";
                (206): return "Mill Hill Magnifica Glass Bead";
                (82): return "PixelHobby";
                (4): return "Caron Collection";
                (2): return "Madeira";
                (11): return "Riolis Wool";
                (9): return "Mayflower";
                (149): return "Dimensions";
                (150): return "DMC Cross";
                (207): return "Preciosa Bead";
                (252): return "Blend";
                (229): return "Custom Bead";
                (253): return "Custom Thread";
                (251): return "Generic Color";
            }
        };
    }
}
