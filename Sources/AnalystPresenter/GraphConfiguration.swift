
public protocol GraphConfiguration {

    func valueLabels(in: ClosedRange<Double>) -> [Graph.Label]
    func dateLabels(in: ClosedRange<Date>) -> [Graph.Label]
    func dataSet(for: RangeQueryResponse, normalizedIn: ClosedRange<Double>) -> Graph.DataSet

}

extension GraphConfiguration {

    public func valueLabels(in: ClosedRange<Double>) -> [Graph.Label] {
        []
    }

    public func dateLabels(in: ClosedRange<Date>) -> [Graph.Label] {
        []
    }

}
