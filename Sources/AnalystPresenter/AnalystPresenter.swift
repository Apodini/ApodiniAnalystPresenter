
public struct AnalystPresenter: Plugin {

    public init() {}

    public var plugins: [Plugin] {
        [
            MetricPresenter(),
            TracePresenter(),
        ]
    }

}
