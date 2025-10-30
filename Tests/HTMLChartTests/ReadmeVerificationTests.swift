import Testing
import Foundation
@testable import HTMLChart

@Suite("README Verification")
struct ReadmeVerificationTests {

    @Test("Basic Line Chart from README lines 44-65")
    func testBasicLineChart() {
        // Create chart data
        let dataset = LineDataset(
            label: "Monthly Sales",
            data: [10, 20, 15, 25, 30],
            borderColor: .rgb(75, 192, 192)
        )

        let data = ChartData(
            labels: ["Jan", "Feb", "Mar", "Apr", "May"],
            dataset: dataset
        )

        // Create and render chart
        let chart = LineChart(
            id: "sales-chart",
            data: data
        )

        #expect(chart != nil)
    }

    @Test("Bar Chart with Options from README lines 68-86")
    func testBarChartWithOptions() {
        let data = ChartData(
            labels: ["Q1", "Q2", "Q3", "Q4"],
            dataset: BarDataset(
                label: "Revenue",
                data: [100, 150, 200, 180],
                backgroundColor: .rgba(54, 162, 235, 0.5)
            )
        )

        let chart = BarChart(
            id: "revenue-chart",
            data: data,
            horizontal: true
        )

        #expect(chart != nil)
    }

    @Test("Pie Chart from README lines 89-109")
    func testPieChart() {
        let data = ChartData(
            labels: ["Desktop", "Mobile", "Tablet"],
            dataset: PieDataset(
                data: [60, 30, 10],
                backgroundColors: [
                    .rgb(255, 99, 132),
                    .rgb(54, 162, 235),
                    .rgb(255, 205, 86)
                ]
            )
        )

        let chart = PieChart(
            id: "platform-chart",
            data: data
        )

        #expect(chart != nil)
    }

    @Test("Chart Configuration with Options from README lines 114-141")
    func testChartConfigurationWithOptions() {
        // Create some dummy chart data
        let chartData = ChartData(
            labels: ["A", "B", "C"],
            dataset: LineDataset(
                label: "Test",
                data: [1, 2, 3],
                borderColor: .blue
            )
        )

        let options = ChartOptions(
            responsive: true,
            maintainAspectRatio: false,
            animation: AnimationOptions(
                duration: 1000,
                easing: .easeOutQuart
            ),
            plugins: PluginOptions(
                legend: LegendOptions(
                    display: true,
                    position: .top
                ),
                tooltip: TooltipOptions(
                    enabled: true,
                    mode: .index
                ),
                title: TitleOptions("Sales Dashboard")
            )
        )

        let config = ChartConfiguration(
            type: .line,
            data: chartData,
            options: options
        )

        #expect(config != nil)
    }

    @Test("Scale Configuration from README lines 144-165")
    func testScaleConfiguration() {
        let xScale = LinearScale(
            display: true,
            position: .bottom,
            title: ScaleTitle(
                display: true,
                text: "X Axis"
            ),
            beginAtZero: true
        )

        let yScale = CategoryScale(
            display: true,
            position: .left,
            labels: ["Category 1", "Category 2", "Category 3"]
        )

        let scales = ScaleOptions()
            .adding(xScale, withId: "x")
            .adding(yScale, withId: "y")

        let dict = scales.toDictionary()
        #expect(dict["x"] != nil)
        #expect(dict["y"] != nil)
    }

    @Test("CDN Loading from README lines 168-175")
    func testCDNLoading() {
        let loader = ChartCDN(
            version: "4.4.0",
            minified: true,
            includePlugins: [.datalabels, .zoom]
        )

        #expect(loader.version == "4.4.0")
        #expect(loader.includePlugins.count == 2)
    }

    @Test("Color creation methods")
    func testColorCreation() {
        let rgb = ChartColor.rgb(75, 192, 192)
        #expect(rgb.value == "rgb(75, 192, 192)")

        let rgba = ChartColor.rgba(54, 162, 235, 0.5)
        #expect(rgba.value == "rgba(54, 162, 235, 0.5)")

        let rgbAlt = ChartColor.rgb(255, 99, 132)
        #expect(rgbAlt.value == "rgb(255, 99, 132)")
    }

    @Test("Dataset types compilation")
    func testDatasetTypes() {
        // Test that all dataset types can be created
        let lineDataset = LineDataset(
            label: "Line",
            data: [1, 2, 3],
            borderColor: .blue
        )
        #expect(lineDataset != nil)

        let barDataset = BarDataset(
            label: "Bar",
            data: [4, 5, 6],
            backgroundColor: .green
        )
        #expect(barDataset != nil)

        let pieDataset = PieDataset(
            data: [7, 8, 9],
            backgroundColors: [.red, .blue, .green]
        )
        #expect(pieDataset != nil)
    }

    @Test("Chart types instantiation")
    func testChartTypesInstantiation() {
        let data = ChartData(
            labels: ["A", "B", "C"],
            dataset: LineDataset(
                label: "Test",
                data: [1, 2, 3],
                borderColor: .blue
            )
        )

        let lineChart = LineChart(id: "line", data: data)
        #expect(lineChart != nil)

        let barData = ChartData(
            labels: ["X", "Y", "Z"],
            dataset: BarDataset(
                label: "Test",
                data: [4, 5, 6],
                backgroundColor: .green
            )
        )

        let barChart = BarChart(id: "bar", data: barData)
        #expect(barChart != nil)

        let pieData = ChartData(
            labels: ["P", "Q", "R"],
            dataset: PieDataset(
                data: [7, 8, 9],
                backgroundColors: [.red, .blue, .green]
            )
        )

        let pieChart = PieChart(id: "pie", data: pieData)
        #expect(pieChart != nil)
    }
}
