//
// This source file is part of the Apodini AnalystPresenter open source project
//
// SPDX-FileCopyrightText: 2021 Paul Schmiedmayer and the project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import AnalystPresenter


extension Color {
    /// Light green color
    public static var lightGray: Color {
        Color(red: 0.75, green: 0.75, blue: 0.75)
    }
    /// Black color
    public static var black: Color {
        Color(red: 0, green: 0, blue: 0)
    }
    /// System blue color
    public static var systemBlue: Color {
        .init(red: 0 / 255, green: 122 / 255, blue: 255 / 255)
    }
    /// System indigo color
    public static var systemIndigo: Color {
        .init(red: 88 / 255, green: 86 / 255, blue: 214 / 255)
    }
    /// System orange color
    public static var systemOrange: Color {
        .init(red: 255 / 255, green: 149 / 255, blue: 0 / 255)
    }
    /// System pink color
    public static var systemPink: Color {
        .init(red: 255 / 255, green: 45 / 255, blue: 85 / 255)
    }
    /// System purple color
    public static var systemPurple: Color {
        .init(red: 175 / 255, green: 82 / 255, blue: 222 / 255)
    }
    /// System red color
    public static var systemRed: Color {
        .init(red: 255 / 255, green: 59 / 255, blue: 48 / 255)
    }
    /// System teal color
    public static var systemTeal: Color {
        .init(red: 90 / 255, green: 200 / 255, blue: 250 / 255)
    }
    /// Collection of all system colors
    public static var systemColors: [Color] {
        [
            .systemBlue,
            .systemIndigo,
            .systemOrange,
            .systemPink,
            .systemPurple,
            .systemRed,
            .systemTeal
        ]
    }
    /// A `GraphConfiguration` with all `systemColors`
    public static var systemColorGraphConfiguration: GraphConfiguration {
        PrometheusGraphConfiguration(
            styles: systemColors.map { color in
                (.line(.init(.quadCurve, color: color, width: 2)), color)
            }
        )
    }
}
