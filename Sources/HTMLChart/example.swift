import Foundation

// Simple example showing how to use the chart components
public struct ChartExamples {
    
    // Example: Create a line chart configuration
    public static func createLineChartConfig() -> ChartConfiguration {
        let dataset = LineDataset(
            label: "Monthly Sales",
            data: [10, 20, 15, 25, 30],
            borderColor: .rgb(75, 192, 192),
            tension: 0.4,
            fill: true
        )
        
        let data = ChartData(
            labels: ["Jan", "Feb", "Mar", "Apr", "May"],
            dataset: dataset
        )
        
        let options = ChartOptions(
            responsive: true,
            maintainAspectRatio: false,
            plugins: PluginOptions(
                legend: LegendOptions(
                    display: true,
                    position: .top
                ),
                title: TitleOptions(
                    display: true,
                    text: .single("Monthly Sales Trend")
                )
            )
        )
        
        return ChartConfiguration(
            type: .line,
            data: data,
            options: options
        )
    }
    
    // Example: Create a bar chart configuration
    public static func createBarChartConfig() -> ChartConfiguration {
        let dataset = BarDataset(
            label: "Quarterly Revenue",
            data: [100, 150, 200, 180],
            backgroundColor: .rgba(54, 162, 235, 0.5)
        )
        
        let data = ChartData(
            labels: ["Q1", "Q2", "Q3", "Q4"],
            dataset: dataset
        )
        
        return ChartConfiguration(
            type: .bar,
            data: data
        )
    }
    
    // Example: Generate JavaScript for a chart
    public static func generateChartJS() -> String {
        let config = createLineChartConfig()
        return config.toJavaScript()
    }
}
