import Foundation
import HTML

/// A responsive chart container that maintains aspect ratio
public struct ResponsiveChart: HTML {
  public let chart: Chart
  public let aspectRatio: Double
  public let maxWidth: Length?
  public let containerClass: Class?

  public init(
    chart: Chart,
    aspectRatio: Double = 2.0,
    maxWidth: Length? = nil,
    containerClass: Class? = nil
  ) {
    self.chart = chart
    self.aspectRatio = aspectRatio
    self.maxWidth = maxWidth
    self.containerClass = containerClass
  }

  /// Convenience initializer with configuration
  public init(
    id: String? = nil,
    configuration: ChartConfiguration,
    aspectRatio: Double = 2.0,
    maxWidth: Length? = nil,
    containerClass: Class? = nil
  ) {
    self.chart = Chart(
      id: id,
      configuration: configuration,
      responsive: true
    )
    self.aspectRatio = aspectRatio
    self.maxWidth = maxWidth
    self.containerClass = containerClass
  }

  public var body: some HTML {
    div {
      div {
        chart
      }
      .position(.absolute)
      .top(.zero)
      .left(.zero)
      .width(.percent(100))
      .height(.percent(100))
    }
    .position(.relative)
    .width(.percent(100))
    .inlineStyle("padding-bottom", "\(100.0 / aspectRatio)%")
    .if(let: maxWidth) { div, maxWidth in
      div.maxWidth(.length(maxWidth))
    }
    .if(let: containerClass) { div, containerClass in
      div.class(containerClass)
    }
  }
}
