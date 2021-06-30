import Apodini
import Foundation
import NIO
import Presenter


public typealias ViewFuture = EventLoopFuture<_CodableView>


public protocol PresenterService {
    var view: ViewFuture { get }
}


extension PresenterService {
    public var encodedView: EventLoopFuture<Blob> {
        view.flatMapThrowing {
            let data = try Presenter.encode(CoderView($0))
            return Blob(data, type: .application(.json))
        }
    }
}


fileprivate struct PresenterServiceStorageKey: StorageKey {
    typealias Value = PresenterService
}


extension Apodini.Application {
    public var presenterService: PresenterService {
        get {
            guard let presenterService = self.storage[PresenterServiceStorageKey.self] else {
                fatalError("You need to add a configuration corresponding to a PresenterService to the WebService configuration to use the presenterService in the Environment")
            }
            
            return presenterService
        }
        set {
            self.storage[PresenterServiceStorageKey.self] = newValue
        }
    }
}
