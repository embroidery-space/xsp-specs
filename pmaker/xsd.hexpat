#pragma magic [10 05 ?? ?? ?? ??] @ 0x00
#pragma endian little

import std.io;
import std.string;
import type.types.rust;

import pmaker.cstr;
import pmaker.color;

usize COLOR_NUMBER_LENGTH = 10 + 1;
usize COLOR_NAME_LENGTH = 40 + 1;
usize BLENDS_NUMBER = 4; // PM limits blends up to 4 colors. The minimum is 2 if they are present.

usize FONT_NAME_LENGTH = 32 + 1;
usize FORMAT_LENGTH = 240;

usize PAGE_HEADER_AND_FOOTER_LENGTH = 119 + 1;

usize FABRIC_COLOR_NAME_LENGTH = 40 + 1;
usize FABRIC_KIND_NAME_LENGTH = 30 + 1;

usize PATTERN_NAME_LENGTH = 40 + 1;
usize AUTHOR_NAME_LENGTH = 40 + 1;
usize COMPANY_NAME_LENGTH = 40 + 1;
usize COPYRIGHT_LENGTH = 200 + 1;
usize PATTERN_NOTES_LENGTH = 2048 + 1;

usize CELLS_NUMBER = 100;
usize CELL_KEYWORDS_NUMBER = 5;
usize CELL_NAME_LENGTH = 50 + 1;
usize CELL_KEYWORD_LENGTH = 20 + 1;

usize FILE_PATH_LENGTH = 259 + 1;
usize HOOP_SIZE_TEXT_LENGTH = 60 + 1;

fn format_boolean(auto value) {
    return bool(value) ? "true" : "false";
};

fn format_millimetres(auto value) {
    return std::format("{:.1f} mm", float(value) / 10f);
};

fn format_points(auto value) {
    return std::format("{:.1f} pt.", float(value) / 10f);
};

fn format_percentage(auto value) {
    return std::format("{}%", value);
};

struct PatternProperties {
    u16 width;
    u16 height;

    // Count of half, quarter and petite stitches.
    u32 small_stitches_count [[hidden]];
    // Count of back, straight and special stitches, french knots and beads.
    u16 joints_count [[hidden]];

    u16 stitches_per_inch_x;
    u16 stitches_per_inch_y;

    // Any change to the pattern file increments this counter.
    u32 action_counter [[hidden]];
    // Always 0x0016. Otherwise PM throws error "Invalid floss in palette. Family ID not recognized. Floss color replaced with default color."
    u16 family_id [[hidden]];
};

struct Blend {
    u8 brand;
    pmaker::SizedCStr<COLOR_NUMBER_LENGTH> number;
};

struct Bead {
    u16 length [[format("format_millimetres")]];
    u16 diameter [[format("format_millimetres")]];
};

struct PaletteItem {
    padding[2];

    u8 brand;
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
    if (bool(is_bead)) {
        Bead bead;
    } else { padding[4]; }

    padding[2];
};

struct Note {
    u16 length [[hidden]];
    pmaker::SizedCStr<length> data;
} [[sealed, format("format_note")]];

fn format_note(ref Note note) {
    return std::format("{}", note.data);
};

struct PaletteItemNotes {
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

struct PaletteItemStrands {
    u16 full [[format("format_strands")]];
    u16 half [[format("format_strands")]];
    u16 quarter [[format("format_strands")]];
    u16 back [[format("format_strands")]];
    u16 french_knot [[format("format_strands")]];
    u16 petite [[format("format_strands")]];
    u16 special [[format("format_strands")]];
    u16 straight [[format("format_strands")]];
};

fn format_strands(u16 strands) {
    return strands == 0 ? "default" : strands;
};

struct Palette {
    u16 size [[hidden]];
    PaletteItem items[size];
    u16 positions[size];
    PaletteItemNotes notes[size];
    PaletteItemStrands strands[size];
};

struct SymbolFormat {
    u16 use_alt_bg_color [[format("format_boolean")]];
    pmaker::Color bg_color; padding[1];
    pmaker::Color fg_color; padding[1];
};

struct LineFormat {
    u16 use_alt_color [[format("format_boolean")]];
    pmaker::Color color; padding[1];
    u16 style;
    u16 thickness [[format("format_points")]];
};

struct NodeFormat {
    u16 use_dot_style [[format("format_boolean")]];
    pmaker::Color color; padding[1];
    u16 use_alt_color [[format("format_boolean")]];
    u16 diameter [[format("format_points")]];
};

struct FontFormat {
    pmaker::SizedCStr<FONT_NAME_LENGTH> font_name;
    padding[2];
    u16 font_weight;
    bool italic;
    padding[11];
    u16 full_half_french_size [[format("format_percentage")]];
    u16 quarter_petite_size [[format("format_percentage")]];
};

struct Formats<auto palette_size> {
    SymbolFormat symbol[palette_size];
    padding[(FORMAT_LENGTH - palette_size) * 10];

    LineFormat back[palette_size];
    padding[(FORMAT_LENGTH - palette_size) * 10];

    padding[FORMAT_LENGTH * 4]; // Unknown formats.

    LineFormat special[palette_size];
    padding[(FORMAT_LENGTH - palette_size) * 10];

    LineFormat straight[palette_size];
    padding[(FORMAT_LENGTH - palette_size) * 10];

    NodeFormat french_knot[palette_size];
    padding[(FORMAT_LENGTH - palette_size) * 10];

    NodeFormat bead[palette_size];
    padding[(FORMAT_LENGTH - palette_size) * 10];

    FontFormat font[palette_size];
    padding[(FORMAT_LENGTH - palette_size) * 53];
};

struct Symbols {
    u16 full [[format("format_symbol")]];
    u16 petite [[format("format_symbol")]];
    u16 half [[format("format_symbol")]];
    u16 quarter [[format("format_symbol")]];
    u16 french_knot [[format("format_symbol")]];
    u16 bead [[format("format_symbol")]];
};

fn format_symbol(u16 value) {
    return value == 0xFFFF ? "unspecified" : value;
};

struct PageMargins {
    u16 left [[format("format_page_margin")]];
    u16 right [[format("format_page_margin")]];
    u16 top [[format("format_page_margin")]];
    u16 bottom [[format("format_page_margin")]];
    u16 header [[format("format_page_margin")]];
    u16 footer [[format("format_page_margin")]];
};

fn format_page_margin(u16 margin) {
    return std::format("{:.2f} in.", float(margin) / 100f);
};

struct PatternSettings {
    pmaker::SizedCStr<FONT_NAME_LENGTH> default_stitch_font;
    padding[20];

    // Applies to `xsd::PatternInfo.notes`.
    pmaker::SizedCStr<FONT_NAME_LENGTH> text_font;
    u16 font_size;
    u16 font_weight;
    u16 italic [[format("format_boolean")]];
    padding[10];

    // 0: "View as stitches"
    // 1: "View as symbols"
    // 2: "View as solid"
    // 3: "View information"
    // 5: "View machine emb. info"
    u16 view;
    u16 zoom;

    u16 show_grid [[format("format_boolean")]];
    u16 show_centering_marks [[format("format_boolean")]];
    u16 show_fabric_colors_with_symbols [[format("format_boolean")]];
    u16 gaps_between_stitches [[format("format_boolean")]];
    padding[4];
    u16 show_rulers [[format("format_boolean")]];

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

    u16 show_page_numbers [[format("format_boolean")]];
    u16 show_adjacent_page_numbers [[format("format_boolean")]];
    u16 center_chart_on_pages [[format("format_boolean")]];

    padding[2];
};

struct GridLine {
    u16 thickness [[format("format_grid_line_thickhness")]]; padding[2];
    pmaker::Color color; padding[3];
};

fn format_grid_line_thickhness(u16 thickness) {
    return std::format("{:.3f} pt" , float(thickness) * (72f / 1000f));
    // Or it is better to convert from pt to cm, mm and in.
    // return std::format("{:.3f} cm" , float(thickness) * (26f / 10000f);
    // return std::format("{:.3f} mm" , float(thickness) * (254f / 10000f);
    // return std::format("{:.3f} in" , float(thickness) / 1000f;
};

struct Grid {
    u16 major_lines_interval;
    padding[2];
    GridLine minor_screen_lines;
    GridLine major_screen_lines;
    GridLine minor_print_lines;
    GridLine major_print_lines;
    padding[12];
};

struct Fabric {
    pmaker::SizedCStr<FABRIC_COLOR_NAME_LENGTH> color_name;
    pmaker::Color color;
};

struct PatternInfo {
    pmaker::SizedCStr<PATTERN_NAME_LENGTH> name;
    pmaker::SizedCStr<AUTHOR_NAME_LENGTH> author;
    pmaker::SizedCStr<COMPANY_NAME_LENGTH> company;
    pmaker::SizedCStr<COPYRIGHT_LENGTH> copyright;
    pmaker::SizedCStr<PATTERN_NOTES_LENGTH> notes;
    u16 additional_fabric_counts[3];
    pmaker::SizedCStr<FABRIC_KIND_NAME_LENGTH> fabric_kind;
};

struct PageSetup {
    u16 print_chart [[format("format_boolean")]]; padding[2];
    u16 print_information [[format("format_boolean")]];

    u16 show_floss_colors [[format("format_boolean")]];
    u16 show_floss_usage [[format("format_boolean")]];
    u16 sort_floss_list [[format("format_boolean")]];

    // 0: "Same as display size"
    // 1: "Span printing over specified number of pages"
    // 2: "Size using specified stitch size"
    // 3: "Fit to one page"
    u16 printed_chart_size;

    if (printed_chart_size == 1) {
        u16 pages_across;
        u16 pages_down;
    } else { padding[4]; }

    padding[2];
    u16 show_page_overlapping [[format("format_boolean")]];
    u16 show_centering_marks [[format("format_boolean")]];
    u16 show_grid_numbers [[format("format_boolean")]];

    if (printed_chart_size == 2) {
        u16 stitches_per_inch [[format("format_page_setup_spi")]];
    } else { padding[2]; }
};

fn format_page_setup_spi(u16 spi) {
    return std::format("{:.1f}", float(spi) / 1000f);
};

// There is no option for a french knot (in contrast to `PaletteItemStrands`).
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

struct StitchOutline {
    u16 use_specified_color [[format("format_boolean")]];
    u16 color_percentage [[format("format_percentage")]];
    pmaker::Color specified_color; padding[1];
    u16 thickness [[format("format_points")]];
};

struct StitchSettings {
    StitchStrands default_strands;
    u16 display_thicknesses[13]; // 1..=12 - strands, 13 - french knot.

    u16 outlined_stitches [[format("format_boolean")]];
    StitchOutline stitch_outline;
};

struct SymbolSpacing {
    u16 y;
    u16 x;
};

struct SymbolSettings {
    SymbolSpacing screen_spacing;
    SymbolSpacing printer_spacing;

    u16 scale_using_maximum_font_width [[format("format_boolean")]];
    u16 scale_using_font_height [[format("format_boolean")]];

    u16 small_stitch_size [[format("format_percentage")]];

    u16 show_stitch_color [[format("format_boolean")]];
    u16 use_large_half_stitch_symbol [[format("format_boolean")]];
    padding[6];

    u16 stitch_size [[format("format_percentage")]];

    u16 use_triangles_behind_quarter_stitches [[format("format_boolean")]];
    u16 draw_symbols_over_backstitches [[format("format_boolean")]];
    padding[2];
};

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

struct HoopColor {
    u8 brand;
    pmaker::SizedCStr<COLOR_NUMBER_LENGTH> number;
};

struct MachineExport {
    padding[2];
    // 0x00: "Brother/Baby Lock/Bernina (*.pes)"
    // 0x01: "Brother/Baby Lock/Bernina (*.pec)"
    // 0x09: "Compucon/Singer PSW (*.xxx)"
    // 0x0E: "Elna XPressive (*.emd)"
    // 0x06: "Janome New Home (*.sew)"
    // 0x0C: "Janome Customizer 10000 (*.jef)"
    // 0x0B: "Melco (*.exp)"
    // 0x03: "Pfaff (*.pcs)"
    // 0x07: "Poem/Singer EU (*.csd)"
    // 0x0A: "Tajima (*.dst)"
    // 0x02: "Viking Husqvarna (*.hus)"
    // 0x0D: "Viking Husqvarna (*.vip)"
    // 0x08: "Viking Husqvarna (Old-style CSD) (*.csd)"
    u8 file_format;
    padding[2];

    u16 hoop_width [[format("format_hoop_size")]];
    u16 hoop_height [[format("format_hoop_size")]];
    pmaker::SizedCStr<HOOP_SIZE_TEXT_LENGTH> hoop_size_text;

    // 0 - strands 1
    // 1 - strands 2
    // 2 - strands 3
    // 3 - strands 4 or more
    u8 full_half_quarter_stitch_thickness[4];
    u8 back_stitch__thickness[4];

    bool show_hoop_boundrary;

    pmaker::SizedCStr<FILE_PATH_LENGTH> file_path;

    u8 amount_of_hoop_to_leave [[format("format_percentage")]];
    bool provide_alignment_stitches;
    if (provide_alignment_stitches) {
        u8 color_option [[format("format_hoop_color")]];
        if (bool(color_option)) {
            HoopColor hoop_color;
        } else { padding[12]; }
    } else { padding[13]; }


    u16 french_knot_diameter [[format("format_percentage")]];
    u16 french_knot_thickness [[format("format_points")]];
};

fn format_hoop_size(u16 hoop_size) {
    float millimetres = float(hoop_size) / 10f;
    float inches = millimetres / (254f / 10f);
    return std::format("{:.0f} mm ({:.1f} in.)", millimetres, inches);
};

fn format_hoop_color(u8 option) {
    return bool(option) ? "Use specified palette": "<use current color>";
};

struct Pattern {
    PatternProperties properties;
    Palette palette;
    Formats<palette.size> formats;
    Symbols symbols[palette.size];
    PatternSettings settings;
    Grid grid;
    Fabric fabric;
    padding[65];
    PatternInfo info;
    PageSetup page_setup;
    padding[188];
    StitchSettings stitch_settings;
    SymbolSettings symbol_settings;
    Library library;
    MachineExport machine_export;
    padding[154];
};

u16 v[4] @ 0x06 [[hidden]];
std::print("Pattern Maker version: {}.{}.{}.{}", v[1], v[0], v[3], v[2]);

Pattern pattern @ 0x02E5;
