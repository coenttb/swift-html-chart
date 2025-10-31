import Foundation
import Testing

@testable import HTMLChart

@Suite("Chart Tests")
struct ChartTests {

  @Test("Create line chart with basic data")
  func testLineChart() {
    let data = ChartData(
      labels: ["January", "February", "March", "April"],
      dataset: LineDataset(
        label: "Sales",
        data: [100, 200, 150, 300],
        borderColor: .blue
      )
    )

    let chart = LineChart(
      id: "test-chart",
      data: data
    )

    // Just ensure it compiles and can be created
    #expect(chart != nil)
  }

  @Test("Create bar chart with multiple datasets")
  func testBarChart() {
    let data = ChartData(
      labels: ["Q1", "Q2", "Q3", "Q4"],
      datasets: [
        BarDataset(
          label: "Product A",
          data: [100, 150, 200, 180],
          backgroundColor: .blue
        ),
        BarDataset(
          label: "Product B",
          data: [80, 120, 160, 140],
          backgroundColor: .green
        ),
      ]
    )

    let chart = BarChart(
      id: "bar-chart",
      data: data,
      horizontal: true
    )

    #expect(chart != nil)
  }

  @Test("Create pie chart with colors")
  func testPieChart() {
    let data = ChartData(
      labels: ["Red", "Blue", "Yellow", "Green"],
      dataset: PieDataset(
        data: [12, 19, 3, 5],
        backgroundColors: [
          .red,
          .blue,
          .yellow,
          .green,
        ]
      )
    )

    let chart = PieChart(
      id: "pie-chart",
      data: data
    )

    #expect(chart != nil)
  }

  @Test("Chart configuration with options")
  func testChartConfiguration() {
    let config = ChartConfiguration(
      type: .line,
      data: ChartData(
        labels: ["A", "B", "C"],
        dataset: LineDataset(
          label: "Test",
          data: [1, 2, 3],
          borderColor: .blue
        )
      ),
      options: ChartOptions(
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
          title: TitleOptions("My Chart")
        )
      )
    )

    let js = config.toJavaScript()
    #expect(js.contains("type: 'line'"))
    #expect(js.contains("responsive: true"))
  }

  @Test("Color creation methods")
  func testColors() {
    let rgb = ChartColor.rgb(255, 0, 0)
    #expect(rgb.value == "rgb(255, 0, 0)")

    let rgba = ChartColor.rgba(0, 255, 0, 0.5)
    #expect(rgba.value == "rgba(0, 255, 0, 0.5)")

    let hex = ChartColor.hex("FF0000")
    #expect(hex.value == "#FF0000")

    let hexWithHash = ChartColor.hex("#00FF00")
    #expect(hexWithHash.value == "#00FF00")
  }

  @Test("Scale configuration")
  func testScales() {
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

  @Test("CDN loader configuration")
  func testCDNLoader() {
    let loader = ChartCDN(
      version: "4.4.0",
      minified: true,
      includePlugins: [.datalabels, .zoom]
    )

    #expect(loader.version == "4.4.0")
    #expect(loader.includePlugins.count == 2)
  }

  @Test("Chart data with various value types")
  func testChartValues() {
    let numberValue: ChartValue = .number(42.5)
    let stringValue: ChartValue = "Category"
    let dateValue: ChartValue = .date(Date())
    let nullValue: ChartValue = nil

    #expect(numberValue.jsValue == "42.5")
    #expect(stringValue.jsValue == "'Category'")
    #expect(nullValue.jsValue == "null")
  }
}
