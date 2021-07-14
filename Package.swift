// swift-tools-version:5.4

import PackageDescription


let package = Package(
    name: "ApodiniAnalystPresenter",
    platforms: [
        .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "ApodiniAnalystPresenter",
            targets: ["ApodiniAnalystPresenter"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/Apodini/Apodini.git", .upToNextMinor(from: "0.3.0")),
        .package(url: "https://github.com/Apodini/ApodiniAsyncHTTPClient.git", .upToNextMinor(from: "0.2.0")),
        .package(url: "https://github.com/Apodini/Analyst.git", .upToNextMinor(from: "0.1.0"))
    ],
    targets: [
        .target(
            name: "ApodiniAnalystPresenter",
            dependencies: [
                .product(name: "Apodini", package: "Apodini"),
                .product(name: "ApodiniAsyncHTTPClient", package: "ApodiniAsyncHTTPClient"),
                .product(name: "AnalystPresenter", package: "Analyst"),
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
