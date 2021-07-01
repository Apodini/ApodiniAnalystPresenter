import Apodini
import ApodiniAsyncHTTPClient
import AnalystPresenter
import PrometheusAnalyst


open class MetricPresenterService<M: Analyst.Metric>: PresenterService {
    let metricsProvider: Prometheus
    let metric: M
    let timeRange: TimeRange
    let title: String
    
    
    open var view: ViewFuture {
        service(title: title, cards: [
            card
        ])
    }
    
    public var card: ViewFuture {
        let query = metric.query(scalar: .delta(metric[timeRange.step])).in(timeRange)
        
        let results: EventLoopFuture<[RangeResult]>
        if let counterQuery = query as? RangeQuery<Analyst.Counter> {
            results = metricsProvider.results(for: counterQuery)
        } else if let gaugeQuery = query as? RangeQuery<Analyst.Gauge> {
            results = metricsProvider.results(for: gaugeQuery)
        } else if let recorderQuery = query as? RangeQuery<Analyst.Recorder> {
            results = metricsProvider.results(for: recorderQuery)
        } else if let timerQuery = query as? RangeQuery<Analyst.Timer> {
            results = metricsProvider.results(for: timerQuery)
        } else {
            return eventLoop.makeFailedFuture(
                ApodiniError(
                    type: .serverError,
                    reason: "Could not match the metric of type \(M.self) to any known Analyst Metric that can be queried by the metricsprovider"
                )
            )
        }

        return results.map { results in
            GraphCard(configuration: Color.systemColorGraphConfiguration, results: results)
                .view(title: self.title, subtitle: "")
        }
    }
    
    var eventLoop: EventLoop {
        metricsProvider.client.eventLoopGroup.next()
    }
    
    
    public init(
        client: HTTPClient,
        prometheusURL: URL,
        metric: M,
        timeRange: TimeRange,
        title: String? = nil
    ) {
        Presenter.use(plugin: AnalystPresenter())
        Presenter.use(view: CoderView.self)

        self.metricsProvider = Prometheus(
            baseURL: prometheusURL,
            client: client
        )
        
        self.metric = metric
        self.timeRange = timeRange
        self.title = title ?? metric.information.label
    }
    
    public func service(title: String, cards: [ViewFuture]) -> ViewFuture {
        EventLoopFuture.whenAllSucceed(cards, on: eventLoop)
            .map { cards in
                ScrollView {
                    VStack {
                        cards
                    }
                    .padding(8)
                }
                .navigationBarTitle(.static(title))
            }
    }
}


public struct MetricsPresenterConfiguration<M: Analyst.Metric>: Configuration {
    let prometheusURL: URL
    let metric: M
    let timeRange: TimeRange
    let title: String?
    
    public init(
        prometheusURL: URL,
        metric: M,
        timeRange: TimeRange = .range(.days(1), step: .minutes(30)),
        title: String? = nil)
    {
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
