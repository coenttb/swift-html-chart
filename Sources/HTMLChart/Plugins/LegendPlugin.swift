import Foundation

/// Legend plugin configuration
public struct LegendOptions: Sendable {
    public let display: Bool?
    public let position: LegendPosition?
    public let align: LegendAlign?
    public let maxHeight: Double?
    public let maxWidth: Double?
    public let fullSize: Bool?
    public let reverse: Bool?
    public let onClick: String? // JavaScript function as string
    public let onHover: String? // JavaScript function as string
    public let onLeave: String? // JavaScript function as string
    public let labels: LegendLabelOptions?
    public let title: LegendTitle?
    public let rtl: Bool?
    public let textDirection: TextDirection?
    
    public init(
        display: Bool? = true,
        position: LegendPosition? = .top,
        align: LegendAlign? = .center,
        maxHeight: Double? = nil,
        maxWidth: Double? = nil,
        fullSize: Bool? = true,
        reverse: Bool? = false,
        onClick: String? = nil,
        onHover: String? = nil,
        onLeave: String? = nil,
        labels: LegendLabelOptions? = nil,
        title: LegendTitle? = nil,
        rtl: Bool? = false,
        textDirection: TextDirection? = .ltr
    ) {
        self.display = display
        self.position = position
        self.align = align
        self.maxHeight = maxHeight
        self.maxWidth = maxWidth
        self.fullSize = fullSize
        self.reverse = reverse
        self.onClick = onClick
        self.onHover = onHover
        self.onLeave = onLeave
        self.labels = labels
        self.title = title
        self.rtl = rtl
        self.textDirection = textDirection
    }
    
    func toDictionary() -> [String: Any] {
        var dict: [String: Any] = [:]
        
        if let display = display {
            dict["display"] = display
        }
        if let position = position {
            dict["position"] = position.rawValue
        }
        if let align = align {
            dict["align"] = align.rawValue
        }
        if let maxHeight = maxHeight {
            dict["maxHeight"] = maxHeight
        }
        if let maxWidth = maxWidth {
            dict["maxWidth"] = maxWidth
        }
        if let fullSize = fullSize {
            dict["fullSize"] = fullSize
        }
        if let reverse = reverse {
            dict["reverse"] = reverse
        }
        if let onClick = onClick {
            dict["onClick"] = onClick
        }
        if let onHover = onHover {
            dict["onHover"] = onHover
        }
        if let onLeave = onLeave {
            dict["onLeave"] = onLeave
        }
        if let labels = labels {
            dict["labels"] = labels.toDictionary()
        }
        if let title = title {
            dict["title"] = title.toDictionary()
        }
        if let rtl = rtl {
            dict["rtl"] = rtl
        }
        if let textDirection = textDirection {
            dict["textDirection"] = textDirection.rawValue
        }
        
        return dict
    }
}

/// Legend position options
public enum LegendPosition: String, Sendable {
    case top
    case left
    case bottom
    case right
    case chartArea
}

/// Legend alignment options
public enum LegendAlign: String, Sendable {
    case start
    case center
    case end
}

/// Text direction for legend
public enum TextDirection: String, Sendable {
    case ltr
    case rtl
}

/// Legend label configuration
public struct LegendLabelOptions: Sendable {
    public let boxWidth: Double?
    public let boxHeight: Double?
    public let color: ChartColor?
    public let font: FontOptions?
    public let padding: Double?
    public let generateLabels: String? // JavaScript function as string
    public let filter: String? // JavaScript function as string
    public let sort: String? // JavaScript function as string
    public let pointStyle: PointStyle?
    public let textAlign: TextAlign?
    public let usePointStyle: Bool?
    public let pointStyleWidth: Double?
    public let useBorderRadius: Bool?
    public let borderRadius: Double?
    
    public init(
        boxWidth: Double? = 40,
        boxHeight: Double? = nil,
        color: ChartColor? = nil,
        font: FontOptions? = nil,
        padding: Double? = 10,
        generateLabels: String? = nil,
        filter: String? = nil,
        sort: String? = nil,
        pointStyle: PointStyle? = nil,
        textAlign: TextAlign? = nil,
        usePointStyle: Bool? = false,
        pointStyleWidth: Double? = nil,
        useBorderRadius: Bool? = false,
        borderRadius: Double? = nil
    ) {
        self.boxWidth = boxWidth
        self.boxHeight = boxHeight
        self.color = color
        self.font = font
        self.padding = padding
        self.generateLabels = generateLabels
        self.filter = filter
        self.sort = sort
        self.pointStyle = pointStyle
        self.textAlign = textAlign
        self.usePointStyle = usePointStyle
        self.pointStyleWidth = pointStyleWidth
        self.useBorderRadius = useBorderRadius
        self.borderRadius = borderRadius
    }
    
    func toDictionary() -> [String: Any] {
        var dict: [String: Any] = [:]
        
        if let boxWidth = boxWidth {
            dict["boxWidth"] = boxWidth
        }
        if let boxHeight = boxHeight {
            dict["boxHeight"] = boxHeight
        }
        if let color = color {
            dict["color"] = color.value
        }
        if let font = font {
            dict["font"] = font.toDictionary()
        }
        if let padding = padding {
            dict["padding"] = padding
        }
        if let generateLabels = generateLabels {
            dict["generateLabels"] = generateLabels
        }
        if let filter = filter {
            dict["filter"] = filter
        }
        if let sort = sort {
            dict["sort"] = sort
        }
        if let pointStyle = pointStyle {
            dict["pointStyle"] = pointStyle.rawValue
        }
        if let textAlign = textAlign {
            dict["textAlign"] = textAlign.rawValue
        }
        if let usePointStyle = usePointStyle {
            dict["usePointStyle"] = usePointStyle
        }
        if let pointStyleWidth = pointStyleWidth {
            dict["pointStyleWidth"] = pointStyleWidth
        }
        if let useBorderRadius = useBorderRadius {
            dict["useBorderRadius"] = useBorderRadius
        }
        if let borderRadius = borderRadius {
            dict["borderRadius"] = borderRadius
        }
        
        return dict
    }
}

/// Text alignment options
public enum TextAlign: String, Sendable {
    case left
    case center
    case right
}

/// Legend title configuration
public struct LegendTitle: Sendable {
    public let display: Bool?
    public let text: String?
    public let color: ChartColor?
    public let font: FontOptions?
    public let padding: PaddingValue?
    
    public init(
        display: Bool? = false,
        text: String? = nil,
        color: ChartColor? = nil,
        font: FontOptions? = nil,
        padding: PaddingValue? = nil
    ) {
        self.display = display
        self.text = text
        self.color = color
        self.font = font
        self.padding = padding
    }
    
    func toDictionary() -> [String: Any] {
        var dict: [String: Any] = [:]
        
        if let display = display {
            dict["display"] = display
        }
        if let text = text {
            dict["text"] = text
        }
        if let color = color {
            dict["color"] = color.value
        }
        if let font = font {
            dict["font"] = font.toDictionary()
        }
        if let padding = padding {
            dict["padding"] = padding.jsValue
        }
        
        return dict
    }
}