// swift-tools-version:5.5

//
// This source file is part of the Apodini AnalystPresenter open source project
//
// SPDX-FileCopyrightText: 2021 Paul Schmiedmayer and the project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import PackageDescription


let package = Package(
    name: "ApodiniAnalystPresenter",
    platforms: [
        .macOS(.v12)
    ],
    products: [
        .library(
            name: "ApodiniAnalystPresenter",
            targets: ["ApodiniAnalystPresenter"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/Apodini/Apodini.git", .upToNextMinor(from: "0.6.1")),
        .package(url: "https://github.com/Apodini/ApodiniAsyncHTTPClient.git", .upToNextMinor(from: "0.3.2")),
        .package(url: "https://github.com/Apodini/Analyst.git", .upToNextMinor(from: "0.1.0")),
        .package(url: "https://github.com/apple/swift-nio.git", from: "2.30.0")
    ],
    targets: [
        .target(
            name: "ApodiniAnalystPresenter",
            dependencies: [
                .product(name: "Apodini", package: "Apodini"),
                .product(name: "ApodiniAsyncHTTPClient", package: "ApodiniAsyncHTTPClient"),
                .product(name: "AnalystPresenter", package: "Analyst"),
                .product(name: "NIO", package: "swift-nio"),
                .product(name: "PrometheusAnalyst", package: "Analyst"),
                .product(name: "JaegerAnalyst", package: "Analyst")
            ]
        ),
        .testTarget(
            name: "ApodiniAnalystPresenterTests",
            dependencies: [
                .target(name: "ApodiniAnalystPresenter")
            ]
        )
    ]
)
