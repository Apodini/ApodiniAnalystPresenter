
public protocol GaugeConfiguration {

    var colors: [Color] { get }
    var thickness: CGFloat { get }
    var scale: CGFloat { get }
    var range: ClosedRange<Double> { get }

    func content(for value: Double) -> View

}

extension GaugeConfiguration {

    public var thickness: CGFloat { 6 }

    public var scale: CGFloat { 1.777 }

    public var colors: [Color] {
        [
            Color(red: 1, green: 59 / 255, blue: 48 / 255),
            Color(red: 1, green: 204 / 255, blue: 0),
            Color(red: 52 / 255, green: 199 / 255, blue: 89 / 255),
        ]
    }

}
