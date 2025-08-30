#!/usr/bin/env swift

import HTMLChart
import HTML

// Generate a complete HTML page with charts
let html = HTMLDocument {
    body {
        div {
            h1 { "Chart.js Test" }
                .margin(.rem(2))
            
            // Line Chart
            div {
                h2 { "Line Chart" }
                LineChart(
                    id: "line-chart",
                    data: ChartData(
                        labels: ["Jan", "Feb", "Mar", "Apr", "May"],
                        dataset: LineDataset(
                            label: "Sales",
                            data: [65, 59, 80, 81, 56],
                            borderColor: .rgb(75, 192, 192),
                            tension: 0.4
                        )
                    ),
                    options: ChartOptions(
                        responsive: true,
                        plugins: PluginOptions(
                            title: TitleOptions("Monthly Sales")
                        )
                    )
                )
            }
            .padding(.rem(2))
            
            // Bar Chart
            div {
                h2 { "Bar Chart" }
                BarChart(
                    id: "bar-chart",
                    data: ChartData(
                        labels: ["Red", "Blue", "Yellow", "Green"],
                        dataset: BarDataset(
                            label: "Votes",
                            data: [12, 19, 3, 5],
                            backgroundColor: .rgba(54, 162, 235, 0.5)
                        )
                    )
                )
            }
            .padding(.rem(2))
        }
        .maxWidth(.px(1200))
        .margin(.auto)
    }
} head: {
    meta(charset: "utf-8")
    title { "Chart Test" }
    
    // Include Chart.js from CDN
    script(src: .init("https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"))
}

// Generate the HTML string
let htmlString = try! String(html)

// Write to file
import Foundation
let fileURL = URL(fileURLWithPath: "generated-charts.html")
try! htmlString.write(to: fileURL, atomically: true, encoding: .utf8)

print("HTML file generated: generated-charts.html")
print("\nYou can open it with: open generated-charts.html")