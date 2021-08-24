//
// This source file is part of the Apodini AnalystPresenter open source project
//
// SPDX-FileCopyrightText: 2021 Paul Schmiedmayer and the project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import _NIOConcurrency
import AnalystPresenter
import Apodini
import ApodiniAsyncHTTPClient
import NIO
import PrometheusAnalyst


/// An instance of a ``PresenterService`` presenting metrics defined by generic metric `M`
open class MetricPresenterService<M: Analyst.Metric>: PresenterService {
    /// An errorr that can be thrown in a `MetricPresenterService`
    public enum MetricPresenterServiceError: Error {
        /// The type could not be mapped to any known Analyst Metric that can be queried by the `metricsProvider`
        case typeMismatch(Any.Type, description: String)
    }
    let metricsProvider: Prometheus
    let metric: M
    let timeRange: TimeRange
    let title: String
    
    
    open var view: _CodableView {
        get async throws { // swiftlint:disable:this implicit_getter
            try await service(title: title, cards: [
                try await card
            ])
        }
    }
    
    /// The card `View` that is presented by the `MetricPresenterService`
    public var card: _CodableView {
        get async throws { // swiftlint:disable:this implicit_getter
            let query = metric.query(scalar: .delta(metric[timeRange.step])).in(timeRange)
            
            let resultsFuture: EventLoopFuture<[RangeResult]>
            if let counterQuery = query as? RangeQuery<Analyst.Counter> {
                resultsFuture = metricsProvider.results(for: counterQuery)
            } else if let gaugeQuery = query as? RangeQuery<Analyst.Gauge> {
                resultsFuture = metricsProvider.results(for: gaugeQuery)
            } else if let recorderQuery = query as? RangeQuery<Analyst.Recorder> {
                resultsFuture = metricsProvider.results(for: recorderQuery)
            } else if let timerQuery = query as? RangeQuery<Analyst.Timer> {
                resultsFuture = metricsProvider.results(for: timerQuery)
            } else {
                throw MetricPresenterServiceError.typeMismatch(
                    M.self,
                    description: "Could not match the metric of type \(M.self) to any known Analyst Metric that can be queried by the metricsProvider"
                )
            }

            let results = try await resultsFuture.get()
            return GraphCard(configuration: Color.systemColorGraphConfiguration, results: results)
                .view(title: self.title, subtitle: "")
        }
    }
    
    var eventLoop: EventLoop {
        metricsProvider.client.eventLoopGroup.next()
    }
    
    
    /// - Parameters:
    ///   - client: The `HTTPClient` that should be used to executre requests to a Prometheus instance
    ///   - prometheusURL: The `URL` where the Prometheus instance can be reached at
    ///   - metric: The `Metric` presented by the ``MetricPresenterService``
    ///   - timeRange: Constrains what time range of the `metric` should be presented
    ///   - title: The title that should be added to the navigration bar containing the metrics information
    public init(
        client: HTTPClient,
        prometheusURL: URL,
        metric: M,
        timeRange: TimeRange,
        title: String? = nil
    ) {
        Presenter.use(plugin: AnalystPresenter())

        self.metricsProvider = Prometheus(
            baseURL: prometheusURL,
            client: client
        )
        
        self.metric = metric
        self.timeRange = timeRange
        self.title = title ?? metric.information.label
    }
    
    
    /// Creates a new `View` based in a `title` and `cards` embedded in a `ScrollView`.
    /// - Parameters:
    ///   - title: The title that should be added to the navigration bar
    ///   - cards: The cards that should be embedded in the view
    /// - Returns: Returns a new `View` based in a `title` and `cards` embedded in a `ScrollView`
    public func service(title: String, cards: [_CodableView]) async throws -> _CodableView {
        ScrollView {
            VStack {
                cards
            }
            .padding(8)
        }.navigationBarTitle(.static(title))
    }
}


/// A `Configuration` that can be used to configure the ``MetricPresenterService``
public struct MetricsPresenterConfiguration<M: Analyst.Metric>: Configuration {
    let prometheusURL: URL
    let metric: M
    let timeRange: TimeRange
    let title: String?
    
    
    /// - Parameters:
    ///   - prometheusURL: The `URL` where the Prometheus instance can be reached at
    ///   - metric: The `Metric` presented by the ``MetricPresenterService``
    ///   - timeRange: Constrains what time range of the `metric` should be presented
    ///   - title: The title that should be added to the navigration bar containing the metrics information
    public init(
        prometheusURL: URL,
        metric: M,
        timeRange: TimeRange = .range(.days(1), step: .minutes(30)),
        title: String? = nil
    ) {
        self.prometheusURL = prometheusURL
        self.metric = metric
        self.timeRange = timeRange
        self.title = title
    }
    
    public func configure(_ app: Application) {
        app.presenterService = MetricPresenterService(
            client: app.httpClient,
            prometheusURL: prometheusURL,
            metric: metric,
            timeRange: timeRange,
            title: title
        )
    }
}
