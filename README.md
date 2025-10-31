# swift-html-chart

[![CI](https://github.com/coenttb/swift-html-chart/workflows/CI/badge.svg)](https://github.com/coenttb/swift-html-chart/actions/workflows/ci.yml)
![Development Status](https://img.shields.io/badge/status-active--development-blue.svg)

A Swift package for type-safe Chart.js integration with [swift-html](https://github.com/coenttb/swift-html), providing a domain model and HTML DSL for creating interactive charts in server-side Swift applications.

## Overview

swift-html-chart provides Swift types that map to Chart.js configuration, enabling compile-time type safety for chart generation. The package integrates with swift-html's DSL to render charts as HTML with embedded JavaScript initialization code.

## Features

- Type-safe Chart.js API using Swift structs and enums
- Support for 8 chart types: Line, Bar, Pie, Doughnut, Radar, Polar Area, Bubble, Scatter
- HTML DSL integration via swift-html
- Full access to Chart.js options through Swift types
- Responsive chart support
- Server-side rendering with automatic JavaScript generation

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

## Quick Start

### Basic Line Chart

```swift
import HTMLChart

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
```

### Bar Chart with Options

```swift
import HTMLChart

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
```

### Pie Chart

```swift
import HTMLChart

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
```

## Usage Examples

### Chart Configuration with Options

```swift
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
```

### Scale Configuration

```swift
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
```

### CDN Loading

```swift
let loader = ChartCDN(
    version: "4.4.0",
    minified: true,
    includePlugins: [.datalabels, .zoom]
)
```

## Chart Types

**Line Chart** - Display data points connected by lines, showing trends over continuous data.

**Bar Chart** - Compare discrete data values using rectangular bars.

**Pie Chart** - Show proportional data as sectors of a circle.

**Doughnut Chart** - Similar to pie chart with a hollow center.

**Radar Chart** - Display multivariate data on a two-dimensional chart with multiple axes.

**Polar Area Chart** - Similar to pie chart but with equal angles and varying radius based on value.

**Bubble Chart** - Display three dimensions of data using position and size.

**Scatter Chart** - Show correlation between two variables using coordinate points.

## Components

### Core Types

- `Chart` - Main chart component that renders canvas and initialization script
- `ChartConfiguration` - Complete chart configuration including type, data, and options
- `ChartData` - Chart data with labels and datasets
- `ChartOptions` - Chart behavior and appearance options
- `ChartColor` - Type-safe color representation (rgb, rgba, hex)

### Dataset Types

- `LineDataset` - Line chart dataset with border and fill options
- `BarDataset` - Bar chart dataset with bar-specific properties
- `PieDataset` - Pie/Doughnut dataset with sector colors
- `RadarDataset` - Radar chart dataset
- `BubbleDataset` - Bubble chart dataset with radius values
- `ScatterDataset` - Scatter chart dataset with point coordinates

### Convenience Charts

- `LineChart`, `BarChart`, `PieChart`, `DoughnutChart`
- `RadarChart`, `PolarAreaChart`, `BubbleChart`, `ScatterChart`

### Plugin Configuration

- `LegendOptions` - Legend display and positioning
- `TooltipOptions` - Tooltip behavior and formatting
- `TitleOptions` - Chart title configuration
- `AnimationOptions` - Animation timing and easing

### Scale Types

- `LinearScale` - Numeric axis with linear progression
- `CategoryScale` - Labeled categories axis
- `ScaleOptions` - Container for multiple scales

## Requirements

- Swift 5.10+
- macOS 14+, iOS 17+, tvOS 17+, watchOS 10+, visionOS 1+

## License

This package is licensed under the Apache License 2.0. See [LICENSE](LICENSE) file for details.

## Contributing

Contributions are welcome. Please submit a Pull Request with a clear description of your changes.

## Related Packages

- [swift-html](https://github.com/coenttb/swift-html) - The Swift library for domain-accurate and type-safe HTML & CSS.
- [coenttb-web](https://github.com/coenttb/coenttb-web) - A Swift package with tools for web development building on swift-web.
