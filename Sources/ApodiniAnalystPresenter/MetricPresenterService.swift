import Apodini
import ApodiniAsyncHTTPClient
import AnalystPresenter
import PrometheusAnalyst

@available(macOS 12, *)
open class MetricPresenterService<Query: RangeMetricQuery & PrometheusRepresentable>: PresenterService {

    let title: String
    let query: Query
    
    open var view: View {
        get async throws {
            try await service(title: title, cards: [card])
        }
    }
    
    public var card: View {
        get async throws {
            let results = try await MetricsSystem.fetch(range: query, at: nil, timeout: nil)
            return  GraphCard(configuration: Color.systemColorGraphConfiguration, results: results)
                .view(title: title, subtitle: String())
        }
    }
    
    public init(
        prometheusURL: URL,
        query: Query,
        title: String
    ) {
        Presenter.use(plugin: AnalystPresenter())
        MetricsSystem.provide(from: prometheusURL)

        self.query = query
        self.title = title
    }
    
    public func service(title: String, cards: [View]) -> View {
        ScrollView {
            VStack {
                cards
            }
            .padding(8)
        }
        .navigationBarTitle(.static(title))
    }
}


@available(macOS 12, *)
public struct MetricsPresenterConfiguration<
    MetricType: Metric & PrometheusRepresentable,
    Duration: MetricAnalyst.TimeInterval & PrometheusRepresentable,
    Step: MetricAnalyst.TimeInterval & PrometheusRepresentable
>: Configuration {

    let prometheusURL: URL
    let metric: MetricType
    let duration: Duration
    let step: Step
    let title: String
    
    public init(
        prometheusURL: URL,
        metric: MetricType,
        duration: Duration,
        step: Step,
        title: String
    ) {
        self.prometheusURL = prometheusURL
        self.metric = metric
        self.duration = duration
        self.step = step
        self.title = title
    }
    
    public func configure(_ app: Application) {
        app.presenterService = MetricPresenterService(
            prometheusURL: prometheusURL,
            query: .rate(metric[step])[duration, step],
            title: title)
    }

}
