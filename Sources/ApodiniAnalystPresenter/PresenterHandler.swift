//
// This source file is part of the Apodini AnalystPresenter open source project
//
// SPDX-FileCopyrightText: 2021 Paul Schmiedmayer and the project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import Apodini
import Logging


/// A `PresenterHandler` provides a `Handler` that returns the encoded view of the ``PresenterService`` stored in the `@Environment`
public struct PresenterHandler: Handler {
    @Apodini.Environment(\.presenterService) var presenterService: PresenterService
    @Apodini.Environment(\.logger) var logger: Logger
    
    @Throws(.serverError, reason: "Could not render the Presenter User Interface")
    var serverError: ApodiniError
    
    
    /// Creates a new `PresenterHandler`.
    public init() {}
    
    
    public func handle() async throws -> Blob {
        do {
            return try await presenterService.encodedView
        } catch {
            logger.error("\(error)")
            throw serverError
        }
    }
}
