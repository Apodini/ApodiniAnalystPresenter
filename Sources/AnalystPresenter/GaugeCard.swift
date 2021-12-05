
public struct GaugeCard<Configuration: GaugeConfiguration> {

    // MARK: Stored Properties

    public var configuration: Configuration

    // MARK: Initialization

    public init(configuration: Configuration) {
        self.configuration = configuration
    }

    // MARK: Methods

    public func view(title: String, subtitle: String = "", value: Double) -> View {
        let normalizedValue = configuration.range.normalize(value)

        return Gauge(
            value: CGFloat(normalizedValue),
            thickness: configuration.thickness,
            scale: configuration.scale,
            colors: configuration.colors.map(ColorCode.init)
        ) {
            configuration.content(for: normalizedValue)
        }
        .metricCard(title: title, subtitle: subtitle)
    }

}
