import Foundation

/// Category scale for string/category data
public struct CategoryScale: Scale {
  public let type: ScaleType = .category
  public let display: Bool?
  public let position: ScalePosition?
  public let offset: Bool?
  public let title: ScaleTitle?
  public let ticks: TickOptions?
  public let grid: GridOptions?
  public let border: BorderOptions?
  public let min: Double?
  public let max: Double?
  public let suggestedMin: Double?
  public let suggestedMax: Double?
  public let reverse: Bool?
  public let stacked: Bool?
  public let weight: Double?
  public let id: String?
  public let clip: Bool?

  // Category-specific properties
  public let labels: [String]?

  public init(
    display: Bool? = true,
    position: ScalePosition? = nil,
    offset: Bool? = true,
    title: ScaleTitle? = nil,
    ticks: TickOptions? = nil,
    grid: GridOptions? = nil,
    border: BorderOptions? = nil,
    min: Double? = nil,
    max: Double? = nil,
    suggestedMin: Double? = nil,
    suggestedMax: Double? = nil,
    reverse: Bool? = false,
    stacked: Bool? = false,
    weight: Double? = nil,
    id: String? = nil,
    clip: Bool? = nil,
    labels: [String]? = nil
  ) {
    self.display = display
    self.position = position
    self.offset = offset
    self.title = title
    self.ticks = ticks
    self.grid = grid
    self.border = border
    self.min = min
    self.max = max
    self.suggestedMin = suggestedMin
    self.suggestedMax = suggestedMax
    self.reverse = reverse
    self.stacked = stacked
    self.weight = weight
    self.id = id
    self.clip = clip
    self.labels = labels
  }

  public func toDictionary() -> [String: Any] {
    var dict = baseDictionary()

    if let labels = labels {
      dict["labels"] = labels
    }

    return dict
  }
}
