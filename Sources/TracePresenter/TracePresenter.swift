
public struct TracePresenter: Plugin {

    public init() {}

    public var views: [View.Type] {
        [
            TraceGraph.self,
        ]
    }

}
