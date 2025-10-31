import HTML
import Testing

@testable import HTMLChart

@Suite("HTML Generation Tests")
struct GenerationTests {

  @Test("Generate simple line chart HTML")
  func testLineChartGeneration() {
    let chart = LineChart(
      id: "test-chart",
      data: ChartData(
        labels: ["Jan", "Feb", "Mar"],
        dataset: LineDataset(
          label: "Test Data",
          data: [10, 20, 15],
          borderColor: .blue
        )
      )
    )

    let html = try! String(chart)

    // Check that canvas element is created
    #expect(html.contains("<canvas"))
    #expect(html.contains("id=\"test-chart\""))

    // Check that script element is created
    #expect(html.contains("<script>"))
    #expect(html.contains("new Chart"))

    // Print for debugging
    print("Generated HTML:")
    print(html)
  }

  @Test("ChartConfiguration generates valid JavaScript")
  func testConfigurationJavaScript() {
    let config = ChartConfiguration(
      type: .line,
      data: ChartData(
        labels: ["A", "B", "C"],
        dataset: LineDataset(
          label: "Test",
          data: [1, 2, 3],
          borderColor: .rgb(255, 0, 0)
        )
      )
    )

    let js = config.toJavaScript()

    // Check basic structure
    #expect(js.contains("type: 'line'"))
    #expect(js.contains("labels: ['A', 'B', 'C']"))
    #expect(js.contains("datasets: ["))
    #expect(js.contains("label: 'Test'"))

    // Print for debugging
    print("Generated JavaScript config:")
    print(js)
  }

  @Test("ChartScript generates initialization code")
  func testScriptGeneration() {
    let config = ChartConfiguration(
      type: .bar,
      data: ChartData(
        labels: ["Q1", "Q2"],
        dataset: BarDataset(
          label: "Revenue",
          data: [100, 150],
          backgroundColor: .green
        )
      )
    )

    let script = ChartScript(
      chartId: "bar-chart",
      configuration: config
    )

    let html = try! String(script)

    // Check that initialization function is created
    #expect(html.contains("init_bar-chart"))
    #expect(html.contains("getElementById('bar-chart')"))
    #expect(html.contains("new Chart"))

    print("Generated script:")
    print(html)
  }

  @Test("Dataset dictionary conversion")
  func testDatasetToDictionary() {
    let dataset = LineDataset(
      label: "Test",
      data: [1, 2, 3],
      borderColor: .rgb(255, 0, 0),
      tension: 0.4,
      fill: true
    )

    let dict = dataset.toDictionary()

    #expect(dict["label"] as? String == "Test")
    #expect(dict["borderColor"] as? String == "rgb(255, 0, 0)")
    #expect(dict["tension"] as? Double == 0.4)

    print("Dataset dictionary:")
    print(dict)
  }
}
