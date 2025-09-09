import Foundation
import HTML

/// Main chart component that renders a Chart.js chart
public struct Chart: HTML {
    public let id: String
    public let configuration: ChartConfiguration
    public let width: CSSTypes.Width?
    public let height: CSSTypes.Height?
    public let containerClass: Class?
    public let responsive: Bool
    public let storeGlobally: Bool
    
    public init(
        id: String? = nil,
        configuration: ChartConfiguration,
        width: CSSTypes.Width? = nil,
        height: CSSTypes.Height? = nil,
        containerClass: Class? = nil,
        responsive: Bool = true,
        storeGlobally: Bool = false
    ) {
        self.id = id ?? "chart-\(UUID().uuidString.prefix(8))"
        self.configuration = configuration
        self.width = width
        self.height = height
        self.containerClass = containerClass
        self.responsive = responsive
        self.storeGlobally = storeGlobally
    }
    
    public var body: some HTML {
        div {
            canvas {}
                .id(id)
                .if(let: width) { canvas, width in
                    canvas.width(width)
                }
                .if(let: height) { canvas, height in
                    canvas.height(height)
                }
            
            ChartScript(
                chartId: id,
                configuration: configuration,
                storeGlobally: storeGlobally
            )
        }
        .if(let: containerClass) { div, containerClass in
            div.class(containerClass)
        }
        .if(!responsive) { div in
            div.inlineStyle("width", width?.description ?? "100%")
               .inlineStyle("height", height?.description ?? "400px")
        }
    }
}

/// Convenience chart components for common chart types
public struct LineChart: HTML {
    private let chart: Chart
    
    public init(
        id: String? = nil,
        data: ChartData,
        options: ChartOptions? = nil,
        width: CSSTypes.Width? = nil,
        height: CSSTypes.Height? = nil,
        storeGlobally: Bool = false
    ) {
        let config = ChartConfiguration(
            type: .line,
            data: data,
            options: options
        )
        self.chart = Chart(
            id: id,
            configuration: config,
            width: width,
            height: height,
            storeGlobally: storeGlobally
        )
    }
    
    public var body: some HTML {
        chart
    }
}

public struct BarChart: HTML {
    private let chart: Chart
    
    public init(
        id: String? = nil,
        data: ChartData,
        options: ChartOptions? = nil,
        width: CSSTypes.Width? = nil,
        height: CSSTypes.Height? = nil,
        horizontal: Bool = false
    ) {
        var finalOptions = options ?? ChartOptions()
        if horizontal {
            finalOptions = ChartOptions(
                responsive: finalOptions.responsive,
                maintainAspectRatio: finalOptions.maintainAspectRatio,
                plugins: finalOptions.plugins,
                scales: finalOptions.scales,
                indexAxis: .y
            )
        }
        
        let config = ChartConfiguration(
            type: .bar,
            data: data,
            options: finalOptions
        )
        self.chart = Chart(
            id: id,
            configuration: config,
            width: width,
            height: height
        )
    }
    
    public var body: some HTML {
        chart
    }
}

public struct PieChart: HTML {
    private let chart: Chart
    
    public init(
        id: String? = nil,
        data: ChartData,
        options: ChartOptions? = nil,
        width: CSSTypes.Width? = nil,
        height: CSSTypes.Height? = nil
    ) {
        let config = ChartConfiguration(
            type: .pie,
            data: data,
            options: options
        )
        self.chart = Chart(
            id: id,
            configuration: config,
            width: width,
            height: height
        )
    }
    
    public var body: some HTML {
        chart
    }
}

public struct DoughnutChart: HTML {
    private let chart: Chart
    
    public init(
        id: String? = nil,
        data: ChartData,
        options: ChartOptions? = nil,
        width: CSSTypes.Width? = nil,
        height: CSSTypes.Height? = nil
    ) {
        let config = ChartConfiguration(
            type: .doughnut,
            data: data,
            options: options
        )
        self.chart = Chart(
            id: id,
            configuration: config,
            width: width,
            height: height
        )
    }
    
    public var body: some HTML {
        chart
    }
}

public struct RadarChart: HTML {
    private let chart: Chart
    
    public init(
        id: String? = nil,
        data: ChartData,
        options: ChartOptions? = nil,
        width: CSSTypes.Width? = nil,
        height: CSSTypes.Height? = nil
    ) {
        let config = ChartConfiguration(
            type: .radar,
            data: data,
            options: options
        )
        self.chart = Chart(
            id: id,
            configuration: config,
            width: width,
            height: height
        )
    }
    
    public var body: some HTML {
        chart
    }
}

public struct PolarAreaChart: HTML {
    private let chart: Chart
    
    public init(
        id: String? = nil,
        data: ChartData,
        options: ChartOptions? = nil,
        width: CSSTypes.Width? = nil,
        height: CSSTypes.Height? = nil
    ) {
        let config = ChartConfiguration(
            type: .polarArea,
            data: data,
            options: options
        )
        self.chart = Chart(
            id: id,
            configuration: config,
            width: width,
            height: height
        )
    }
    
    public var body: some HTML {
        chart
    }
}


public struct BubbleChart: HTML {
    private let chart: Chart
    
    public init(
        id: String? = nil,
        data: ChartData,
        options: ChartOptions? = nil,
        width: CSSTypes.Width? = nil,
        height: CSSTypes.Height? = nil
    ) {
        let config = ChartConfiguration(
            type: .bubble,
            data: data,
            options: options
        )
        self.chart = Chart(
            id: id,
            configuration: config,
            width: width,
            height: height
        )
    }
    
    public var body: some HTML {
        chart
    }
}

public struct ScatterChart: HTML {
    private let chart: Chart
    
    public init(
        id: String? = nil,
        data: ChartData,
        options: ChartOptions? = nil,
        width: CSSTypes.Width? = nil,
        height: CSSTypes.Height? = nil
    ) {
        let config = ChartConfiguration(
            type: .scatter,
            data: data,
            options: options
        )
        self.chart = Chart(
            id: id,
            configuration: config,
            width: width,
            height: height
        )
    }
    
    public var body: some HTML {
        chart
    }
}
