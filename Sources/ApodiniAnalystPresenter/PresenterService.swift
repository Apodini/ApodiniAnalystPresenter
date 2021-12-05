import Apodini
import Foundation
import NIO
import Presenter

@available(macOS 12, *)
public protocol PresenterService {
    var view: View { get async throws }
}


@available(macOS 12, *)
extension PresenterService {
    public var encodedView: Blob {
        get async throws {
            let view = try await self.view
            let data = try Presenter.encode(CoderView(view))
            return Blob(data, type: .application(.json))
        }
    }
}


@available(macOS 12, *)
fileprivate struct PresenterServiceStorageKey: StorageKey {
    typealias Value = PresenterService
}

@available(macOS 12, *)
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
