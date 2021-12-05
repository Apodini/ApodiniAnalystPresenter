
public struct PercentageGaugeConfiguration: GaugeConfiguration {

    public init() {}

    public var range: ClosedRange<Double> {
        0...1
    }

    public func content(for value: Double) -> View {
        Text(.static(Int(value * 100).description + " %"))
            .padding(4)
    }

}
