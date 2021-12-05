// swift-tools-version:5.4

import PackageDescription


let package = Package(
    name: "ApodiniAnalystPresenter",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
    ],
    products: [
        .library(
            name: "ApodiniAnalystPresenter",
            targets: ["ApodiniAnalystPresenter"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Apodini/Apodini.git", from: "0.2.0"),
        .package(url: "https://github.com/Apodini/Analyst.git", .branch("kraft")),
        .package(url: "https://github.com/Apodini/Presenter.git", .branch("kraft")),
    ],
    targets: [

        .target(
            name: "MetricPresenter",
            dependencies: [
                .product(name: "ChartPresenter", package: "Presenter"),
            ]),
        .target(
            name: "TracePresenter",
            dependencies: [
                .product(name: "Presenter", package: "Presenter"),
            ]),
        .target(
            name: "AnalystPresenter",
            dependencies: [
                .target(name: "MetricPresenter"),
                .target(name: "TracePresenter"),
                .product(name: "Analyst", package: "Analyst"),
            ]),
        .target(
            name: "ApodiniAnalystPresenter",
            dependencies: [
                .product(name: "Apodini", package: "Apodini"),
                .target(name: "AnalystPresenter"),
                .product(name: "PrometheusAnalyst", package: "Analyst"),
                .product(name: "JaegerAnalyst", package: "Analyst")
            ]),
        .testTarget(
            name: "ApodiniAnalystPresenterTests",
            dependencies: [
                .target(name: "ApodiniAnalystPresenter")
            ]),
    ]
)
