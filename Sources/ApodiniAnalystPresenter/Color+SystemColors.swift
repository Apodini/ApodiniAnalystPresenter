import AnalystPresenter


extension Color {
    static var lightGray: Color {
        Color(red: 0.75, green: 0.75, blue: 0.75)
    }

    static var black: Color {
        Color(red: 0, green: 0, blue: 0)
    }
    
    static var systemBlue: Color {
        .init(red: 0 / 255, green: 122 / 255, blue: 255 / 255)
    }

    static var systemIndigo: Color {
        .init(red: 88 / 255, green: 86 / 255, blue: 214 / 255)
    }

    static var systemOrange: Color {
        .init(red: 255 / 255, green: 149 / 255, blue: 0 / 255)
    }

    static var systemPink: Color {
        .init(red: 255 / 255, green: 45 / 255, blue: 85 / 255)
    }

    static var systemPurple: Color {
        .init(red: 175 / 255, green: 82 / 255, blue: 222 / 255)
    }

    static var systemRed: Color {
        .init(red: 255 / 255, green: 59 / 255, blue: 48 / 255)
    }

    static var systemTeal: Color {
        .init(red: 90 / 255, green: 200 / 255, blue: 250 / 255)
    }
}
