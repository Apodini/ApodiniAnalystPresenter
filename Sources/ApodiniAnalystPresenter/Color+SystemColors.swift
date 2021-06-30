import AnalystPresenter


extension Color {
    public static var lightGray: Color {
        Color(red: 0.75, green: 0.75, blue: 0.75)
    }

    public static var black: Color {
        Color(red: 0, green: 0, blue: 0)
    }
    
    public static var systemBlue: Color {
        .init(red: 0 / 255, green: 122 / 255, blue: 255 / 255)
    }

    public static var systemIndigo: Color {
        .init(red: 88 / 255, green: 86 / 255, blue: 214 / 255)
    }

    public static var systemOrange: Color {
        .init(red: 255 / 255, green: 149 / 255, blue: 0 / 255)
    }

    public static var systemPink: Color {
        .init(red: 255 / 255, green: 45 / 255, blue: 85 / 255)
    }

    public static var systemPurple: Color {
        .init(red: 175 / 255, green: 82 / 255, blue: 222 / 255)
    }

    public static var systemRed: Color {
        .init(red: 255 / 255, green: 59 / 255, blue: 48 / 255)
    }

    public static var systemTeal: Color {
        .init(red: 90 / 255, green: 200 / 255, blue: 250 / 255)
    }
    
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
    
    public static var systemColorGraphConfiguration: GraphConfiguration {
        PrometheusGraphConfiguration(styles:
            systemColors.map { color in
                (.line(.init(.quadCurve, color: color, width: 2)), color)
            }
        )
    }
}
