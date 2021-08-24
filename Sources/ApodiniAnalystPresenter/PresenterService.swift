//
// This source file is part of the Apodini AnalystPresenter open source project
//
// SPDX-FileCopyrightText: 2021 Paul Schmiedmayer and the project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import _NIOConcurrency
import Apodini
import Foundation
import NIO
import Presenter


/// A ``PresenterService`` returns a `View & Codable` instance that can be returned by an ``PresenterHandler``
public protocol PresenterService {
    /// The view returned by the ``PresenterHandler``
    var view: _CodableView { get async throws }
}


extension PresenterService {
    /// An encoded version of the ``view`` property as a `Blob`
    public var encodedView: Blob {
        get async throws { // swiftlint:disable:this implicit_getter
            let data = try Presenter.encode(CoderView(try await view))
            return Blob(data, type: .application(.json))
        }
    }
}


private struct PresenterServiceStorageKey: StorageKey {
    typealias Value = PresenterService
}


extension Apodini.Application {
    /// A shared instance conforming to `PresenterService` stored in the `@Environment`
    public var presenterService: PresenterService {
        get {
            guard let presenterService = self.storage[PresenterServiceStorageKey.self] else {
                fatalError(
                    """
                    You need to add a configuration corresponding to a PresenterService to the WebService configuration
                    to use the presenterService in the Environment
                    """
                )
            }
            
            return presenterService
        }
        set {
            self.storage[PresenterServiceStorageKey.self] = newValue
        }
    }
}
