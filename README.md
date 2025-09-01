# swift-html-chart

A Swift package for type-safe Chart.js integration with [swift-html](https://github.com/coenttb/swift-html), providing a domain model and HTML DSL for creating interactive charts in server-side Swift applications.

## Features

- 🎯 **Type-safe Chart.js API** - Swift types for Chart.js configuration
- 📊 **8 Chart Types** - Line, Bar, Pie, Doughnut, Radar, Polar Area, Bubble, Scatter
- 🔧 **HTML DSL Integration** - Seamless integration with swift-html
- 🎨 **Customizable** - Full access to Chart.js options through Swift types
- 📱 **Responsive** - Built-in responsive chart support
- 🚀 **Server-Side Rendering** - Generate charts in server-rendered HTML

## Installation

Add swift-html-chart to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/coenttb/swift-html-chart", from: "0.0.1")
]
```

Add to your target:

```swift
.target(
    name: "YourTarget",
    dependencies: [
        .product(name: "HTMLChart", package: "swift-html-chart")
    ]
)
```

## Usage

### Basic Line Chart

```swift
import HTMLChart

// Create chart data
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

// Create chart configuration
let config = ChartConfiguration(
    type: .line,
    data: data,
    options: ChartOptions(
        responsive: true,
        maintainAspectRatio: false
    )
)

// Render in HTML
let html = div {
    Chart(
        id: "sales-chart",
        configuration: config,
        width: .px(800),
        height: .px(400)
    )
}
```

### Using Convenience Components

```swift
import HTMLChart

// Line Chart
LineChart(
    id: "my-line-chart",
    data: ChartData(
        labels: ["Q1", "Q2", "Q3", "Q4"],
        dataset: LineDataset(
            label: "Revenue",
            data: [100, 150, 200, 180]
        )
    ),
    options: ChartOptions(
        plugins: PluginOptions(
            title: TitleOptions(
                display: true,
                text: .single("Quarterly Revenue")
            )
        )
    )
)

// Bar Chart
BarChart(
    data: ChartData(
        labels: ["Product A", "Product B", "Product C"],
        dataset: BarDataset(
            label: "Sales",
            data: [30, 50, 20],
            backgroundColor: .rgba(54, 162, 235, 0.5)
        )
    ),
    horizontal: true  // Horizontal bar chart
)

// Pie Chart
PieChart(
    data: ChartData(
        labels: ["Desktop", "Mobile", "Tablet"],
        dataset: PieDataset(
            data: [60, 30, 10],
            backgroundColor: [
                .rgb(255, 99, 132),
                .rgb(54, 162, 235),
                .rgb(255, 205, 86)
            ]
        )
    )
)
```

### Advanced Configuration

```swift
let options = ChartOptions(
    responsive: true,
    plugins: PluginOptions(
        legend: LegendOptions(
            display: true,
            position: .top,
            labels: LegendLabelOptions(
                font: FontOptions(size: 14),
                padding: 20
            )
        ),
        tooltip: TooltipOptions(
            enabled: true,
            mode: .index,
            intersect: false
        ),
        title: TitleOptions(
            display: true,
            text: .single("Sales Dashboard"),
            font: FontOptions(
                size: 20,
                weight: .bold
            )
        )
    ),
    scales: ScalesOptions(
        x: ScaleOptions(
            display: true,
            grid: GridOptions(display: false)
        ),
        y: ScaleOptions(
            display: true,
            beginAtZero: true,
            ticks: TickOptions(
                stepSize: 10
            )
        )
    ),
    animation: AnimationOptions(
        duration: 1000,
        easing: .easeInOutQuart
    )
)
```

### Integration with HTML Pages

```swift
import HTML
import HTMLChart

struct DashboardPage: HTML {
    var body: some HTML {
        html {
            head {
                title { "Analytics Dashboard" }
                // Include Chart.js library
                script { "" }
                    .src("https://cdn.jsdelivr.net/npm/chart.js")
            }
            body {
                h1 { "Sales Analytics" }
                
                div {
                    LineChart(
                        id: "revenue-chart",
                        data: revenueData,
                        options: chartOptions
                    )
                }
                .class("chart-container")
            }
        }
    }
}
```

## Chart Types

### Line Chart
Ideal for showing trends over time.

### Bar Chart  
Perfect for comparing quantities across categories.

### Pie & Doughnut Charts
Best for showing proportions of a whole.

### Radar Chart
Great for comparing multiple variables.

### Polar Area Chart
Similar to pie chart but with equal angles and varying radius.

### Bubble Chart
Display three dimensions of data.

### Scatter Chart
Show correlation between variables.

## Components

### Core Components
- `Chart` - Main chart component
- `ChartConfiguration` - Complete chart configuration
- `ChartData` - Chart data with labels and datasets
- `ChartOptions` - Chart behavior and appearance options

### Dataset Types
- `LineDataset` - Line chart dataset
- `BarDataset` - Bar chart dataset  
- `PieDataset` - Pie/Doughnut dataset
- `RadarDataset` - Radar chart dataset
- `BubbleDataset` - Bubble chart dataset
- `ScatterDataset` - Scatter chart dataset

### Convenience Charts
- `LineChart`, `BarChart`, `PieChart`, `DoughnutChart`
- `RadarChart`, `PolarAreaChart`, `BubbleChart`, `ScatterChart`

## Requirements

- Swift 5.10+
- macOS 14+, iOS 17+, tvOS 17+, watchOS 10+, visionOS 1+

## License

This package is licensed under the Apache License 2.0. See [LICENSE](LICENSE) file for details.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## Related Packages

- [swift-html](https://github.com/coenttb/swift-html) - Type-safe HTML DSL for Swift
- [coenttb-web](https://github.com/coenttb/coenttb-web) - Full-stack Swift web framework