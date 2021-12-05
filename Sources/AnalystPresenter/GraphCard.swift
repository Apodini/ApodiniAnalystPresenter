
public struct GraphCard {

    // MARK: Stored Properties

    public var configuration: GraphConfiguration
    public var results: [RangeQueryResponse]

    // MARK: Initialization

    public init(configuration: GraphConfiguration, results: [RangeQueryResponse]) {
        self.configuration = configuration
        self.results = results
    }

    // MARK: Methods

    public func view(title: String, subtitle: String = "") -> View {

        let max = results
            .map { $0.values.map(\.value).max() ?? -.greatestFiniteMagnitude }
            .max() ?? 1

        let min = results
            .map { $0.values.map(\.value).min() ?? .greatestFiniteMagnitude }
            .min() ?? -1

        let dates = results.flatMap { $0.values.map(\.date) }
        let startDate = dates.min() ?? Date()
        let endDate = dates.max() ?? Date()

        let range = (min - .ulpOfOne)...(max + .ulpOfOne)

        let data = results
            .map { configuration.dataSet(for: $0, normalizedIn: range) }

        return Graph(
            trailingLabels: configuration.valueLabels(in: range),
            bottomLabels: configuration.dateLabels(in: startDate...endDate),
            data: data,
            gridWidth: 1
        )
        .metricCard(title: title, subtitle: subtitle)
    }

}
