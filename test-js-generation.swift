#!/usr/bin/env swift

// Simple test to see what JavaScript is generated
import HTMLChart
import Foundation

// Create a simple line chart configuration
let dataset = LineDataset(
    label: "Test Data",
    data: [10, 20, 15],
    borderColor: .rgb(255, 0, 0)
)

let data = ChartData(
    labels: ["A", "B", "C"],
    dataset: dataset
)

let config = ChartConfiguration(
    type: .line,
    data: data
)

// Print the generated JavaScript
print("Generated JavaScript configuration:")
print("=================================")
print(config.toJavaScript())
print("=================================")

// Test dataset dictionary
print("\nDataset dictionary:")
print(dataset.toDictionary())

// Test ChartScript generation
let script = ChartScript(
    chartId: "test-chart",
    configuration: config
)

print("\nFull initialization script:")
print("=================================")
// We need to render the script HTML element
import HTML
let scriptHTML = try! String(script)
print(scriptHTML)