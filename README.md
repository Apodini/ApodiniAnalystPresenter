# Apodini Analyst Presenter

`ApodiniAnalystPresenter` combines [Analyst](https://github.com/Apodini/Analyst) and [Presenter](https://github.com/Apodini/Presenter) with the [Apodini](https://github.com/Apodini/Apodini) framework used to create web services.

## Using Apodini Analyst Presenter

The framework defines the `PresenterService` protocol:
```swift
public protocol PresenterService {
    var view: ViewFuture { get }
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
Contributions to this project are welcome. Please make sure to read the [contribution guidelines](https://github.com/Apodini/.github/blob/release/CONTRIBUTING.md) first.

## License
This project is licensed under the MIT License. See [License](https://github.com/Apodini/ApodiniAnalystPresenter/blob/release/LICENSE) for more information.
