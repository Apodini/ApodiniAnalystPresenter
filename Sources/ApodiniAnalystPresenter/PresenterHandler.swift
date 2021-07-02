import Apodini
import Logging


public struct PresenterHandler: Handler {
    @Apodini.Environment(\.presenterService) var presenterService: PresenterService
    @Apodini.Environment(\.logger) var logger: Logger
    
    @Throws(.serverError, reason: "Could not render the Presenter User Interface")
    var serverError: ApodiniError
    
    
    public init() {}
    
    
    public func handle() -> EventLoopFuture<Blob> {
        presenterService
            .encodedView
            .flatMapErrorThrowing { error in
                logger.error("\(error)")
                throw serverError
            }
    }
}
