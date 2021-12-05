
extension ClosedRange where Bound: FloatingPoint {

    public func normalize(_ element: Bound) -> Bound {
        (element - lowerBound) / (upperBound - lowerBound)
    }

    public func value(atPercentage percentage: Bound) -> Bound {
        percentage * (upperBound - lowerBound) + lowerBound
    }

}
