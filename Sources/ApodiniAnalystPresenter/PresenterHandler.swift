import Apodini
import Logging


@available(macOS 12, *)
public struct PresenterHandler: Handler {

    @Apodini.Environment(\.presenterService) var presenterService: PresenterService
    @Apodini.Environment(\.logger) var logger: Logger
    @Apodini.Environment(\.eventLoopGroup) var eventLoopGroup: EventLoopGroup
    
    @Throws(.serverError, reason: "Could not render the Presenter User Interface")
    var serverError: ApodiniError

    public init() {}
    
    public func handle() -> EventLoopFuture<Blob> {
        let promise = eventLoopGroup.next().makePromise(of: Blob.self)
        promise.completeWithTask {
            try await presenterService.encodedView
        }
        return promise.futureResult
            .flatMapErrorThrowing { error in
                logger.error("\(error)")
                throw serverError
            }
    }

}
