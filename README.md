<!--

This source file is part of the Apodini AnalystPresenter open source project

SPDX-FileCopyrightText: 2021 Paul Schmiedmayer and the project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>

SPDX-License-Identifier: MIT

-->

# Apodini Analyst Presenter

[![DOI](https://zenodo.org/badge/381726479.svg)](https://zenodo.org/badge/latestdoi/381726479)
[![codecov](https://codecov.io/gh/Apodini/ApodiniAnalystPresenter/branch/develop/graph/badge.svg?token=bYHXoQcvuK)](https://codecov.io/gh/Apodini/ApodiniAnalystPresenter)
[![jazzy](https://raw.githubusercontent.com/Apodini/ApodiniAnalystPresenter/gh-pages/badge.svg)](https://apodini.github.io/ApodiniAnalystPresenter/)
[![Build and Test](https://github.com/Apodini/ApodiniAnalystPresenter/actions/workflows/build-and-test.yml/badge.svg)](https://github.com/Apodini/ApodiniAnalystPresenter/actions/workflows/build-and-test.yml)

`ApodiniAnalystPresenter` combines [Analyst](https://github.com/Apodini/Analyst) and [Presenter](https://github.com/Apodini/Presenter) with the [Apodini](https://github.com/Apodini/Apodini) framework used to create web services.

## Using Apodini Analyst Presenter

The framework defines the `PresenterService` protocol:
```swift
public protocol PresenterService {
    var view: _CodableView { get async throws }
}
```
`PresenterService` protocol instances need to provide a Presenter `View` (`_CodableView`).  
Instances conforming to this protocol can be injected in the Apodini `@Environment` and retrieved using `@Environment(\.presenterService) var presenterService: PresenterService` in `Handler` instances.

The `PresenterHandler` provides a reusable implementation of an Apodini `Handler` that offers the view returned in a `PresenterService`.

Developers wanting to use [Analyst](https://github.com/Apodini/Analyst) and [Presenter](https://github.com/Apodini/Presenter) in combination with [Apodini](https://github.com/Apodini/Apodini) can create types conforming to `PresenterService` to that can be served to consumers using Apodini endpoints.

## Metrics Presenter Service

`MetricPresenterService` is a reference implementation conforming to `PresenterService` that showcases a `PresenterService` that presents a view showcasing a user-defined `Metric`. Developers can configure and create the `MetricPresenterService` using the `MetricsPresenterConfiguration` as defined below:
```swift
import Apodini
import ApodiniAnalystPresenter
import ArgumentParser
import Foundation


@main
struct ProcessingWebService: WebService {
    @Option var prometheusURL = URL(string: "http://localhost:9092")!
    
    
    var configuration: Apodini.Configuration {
        // Configure the UI Metrics Service with the passed in arguments
        MetricsPresenterConfiguration(
            prometheusURL: prometheusURL,
            metric: Counter(
                label: "hotspots_usage",
                dimensions: ["job": "processing", "path": "user/{id}/hotspots"]
            ),
            title: "Processing"
        )
        
        // ...
    }

    
    var content: some Component {
        // ...
    }
}
```

## Contributing
Contributions to this project are welcome. Please make sure to read the [contribution guidelines](https://github.com/Apodini/.github/blob/main/CONTRIBUTING.md) and the [contributor covenant code of conduct](https://github.com/Apodini/.github/blob/main/CODE_OF_CONDUCT.md) first.

## License
This project is licensed under the MIT License. See [License](https://github.com/Apodini/ApodiniAnalystPresenter/blob/develop/LICENSE) for more information.
