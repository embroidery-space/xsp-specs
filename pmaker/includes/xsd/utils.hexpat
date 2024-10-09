#pragma once

import std.io;

namespace auto xsd {
    namespace format {
        /// Formats any integer into a boolean.
        /// It is needed because the file format is quite weird.
        /// This function is used to format the output value to understand the data better.
        fn boolean(auto value) {
            return bool(value) ? "true" : "false";
        };

        fn millimetres(auto value) {
            return std::format("{:.1f} mm", float(value) / 10f);
        };

        fn points(auto value) {
            return std::format("{:.1f} pt.", float(value) / 10f);
        };

        fn percentage(auto value) {
            return std::format("{}%", value);
        };
    }
}
