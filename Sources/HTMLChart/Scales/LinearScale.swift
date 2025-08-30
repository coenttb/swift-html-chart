import Foundation

/// Linear scale for numeric data
public struct LinearScale: Scale {
    public let type: ScaleType = .linear
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
    
    // Linear-specific properties
    public let beginAtZero: Bool?
    public let grace: Grace?
    
    public init(
        display: Bool? = true,
        position: ScalePosition? = nil,
        offset: Bool? = nil,
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
        beginAtZero: Bool? = false,
        grace: Grace? = nil
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
        self.beginAtZero = beginAtZero
        self.grace = grace
    }
    
    public func toDictionary() -> [String: Any] {
        var dict = baseDictionary()
        
        if let beginAtZero = beginAtZero {
            dict["beginAtZero"] = beginAtZero
        }
        if let grace = grace {
            dict["grace"] = grace.jsValue
        }
        
        return dict
    }
}

/// Grace value for adding padding to scale range
public enum Grace: Sendable {
    case pixels(Double)
    case percentage(Double)
    
    var jsValue: Any {
        switch self {
        case .pixels(let value):
            return value
        case .percentage(let value):
            return "\(value)%"
        }
    }
}