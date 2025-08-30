import Foundation

/// Represents a color in Chart.js, supporting various formats
public struct ChartColor: Sendable, Codable, ExpressibleByStringLiteral {
    public let value: String
    
    public init(_ value: String) {
        self.value = value
    }
    
    public init(stringLiteral value: String) {
        self.value = value
    }
    
    /// Create an RGB color
    public static func rgb(_ red: Int, _ green: Int, _ blue: Int) -> ChartColor {
        ChartColor("rgb(\(red), \(green), \(blue))")
    }
    
    /// Create an RGBA color with alpha
    public static func rgba(_ red: Int, _ green: Int, _ blue: Int, _ alpha: Double) -> ChartColor {
        ChartColor("rgba(\(red), \(green), \(blue), \(alpha))")
    }
    
    /// Create a hex color
    public static func hex(_ hex: String) -> ChartColor {
        ChartColor(hex.hasPrefix("#") ? hex : "#\(hex)")
    }
    
    /// Create an HSL color
    public static func hsl(_ hue: Int, _ saturation: Int, _ lightness: Int) -> ChartColor {
        ChartColor("hsl(\(hue), \(saturation)%, \(lightness)%)")
    }
    
    /// Create an HSLA color with alpha
    public static func hsla(_ hue: Int, _ saturation: Int, _ lightness: Int, _ alpha: Double) -> ChartColor {
        ChartColor("hsla(\(hue), \(saturation)%, \(lightness)%, \(alpha))")
    }
    
    /// Add transparency to a color
    public func withAlpha(_ alpha: Double) -> ChartColor {
        // This is a simplified version - in production you'd parse the color
        ChartColor("\(value)")
    }
}

// MARK: - Common Colors
extension ChartColor {
    public static let red = ChartColor("rgb(255, 99, 132)")
    public static let orange = ChartColor("rgb(255, 159, 64)")
    public static let yellow = ChartColor("rgb(255, 205, 86)")
    public static let green = ChartColor("rgb(75, 192, 192)")
    public static let blue = ChartColor("rgb(54, 162, 235)")
    public static let purple = ChartColor("rgb(153, 102, 255)")
    public static let grey = ChartColor("rgb(201, 203, 207)")
    
    public static let transparent = ChartColor("transparent")
    public static let white = ChartColor("white")
    public static let black = ChartColor("black")
}

/// Represents a gradient for Chart.js
public struct ChartGradient: Sendable {
    public enum Direction: Sendable {
        case vertical
        case horizontal
        case diagonal
        case radial
    }
    
    public struct ColorStop: Sendable {
        public let offset: Double
        public let color: ChartColor
        
        public init(offset: Double, color: ChartColor) {
            self.offset = offset
            self.color = color
        }
    }
    
    public let direction: Direction
    public let colors: [ColorStop]
    
    public init(direction: Direction, colors: [ColorStop]) {
        self.direction = direction
        self.colors = colors
    }
    
    /// Convenience initializer for simple two-color gradient
    public init(from: ChartColor, to: ChartColor, direction: Direction = .vertical) {
        self.direction = direction
        self.colors = [
            ColorStop(offset: 0, color: from),
            ColorStop(offset: 1, color: to)
        ]
    }
}
