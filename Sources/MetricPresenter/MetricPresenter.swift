
public struct MetricPresenter: Plugin {

    public init() {}

    public var views: [View.Type] {
        [
            Graph.self,
        ]
    }

    public var viewModifiers: [ViewModifier.Type] {
        [
            GaugeModifier.self,
            MetricCard.self,
            Card.self,
        ]
    }

    public var plugins: [Plugin.Type] {
        [
            ChartPresenter.self,
        ]
    }

}
