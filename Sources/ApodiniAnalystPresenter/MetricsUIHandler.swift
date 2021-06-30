import Apodini


public struct MetricsUIHandler: Handler {
    @Apodini.Environment(\.presenterService) var presenterService: PresenterService
    
    @Throws(.serverError, reason: "Could not render the Presenter User Interface")
    var serverError: ApodiniError
    
    
    public init() {}
    
    
    public func handle() -> EventLoopFuture<Blob> {
        presenterService
            .encodedView
            .flatMapErrorThrowing { _ in
                throw serverError
            }
    }
}
