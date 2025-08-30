import Foundation

/// Represents a data point in a chart
public struct ChartPoint: Sendable, Codable {
    public let x: ChartValue
    public let y: ChartValue
    public let r: Double? // For bubble charts
    
    public init(x: ChartValue, y: ChartValue, r: Double? = nil) {
        self.x = x
        self.y = y
        self.r = r
    }
    
    /// Convenience initializer for numeric points
    public init(x: Double, y: Double, r: Double? = nil) {
        self.x = .number(x)
        self.y = .number(y)
        self.r = r
    }
    
    /// Convenience initializer for time series
    public init(date: Date, value: Double, r: Double? = nil) {
        self.x = .date(date)
        self.y = .number(value)
        self.r = r
    }
    
    /// Convenience initializer for category data
    public init(category: String, value: Double, r: Double? = nil) {
        self.x = .string(category)
        self.y = .number(value)
        self.r = r
    }
}

/// Represents a value that can be used in a chart (number, string, or date)
public enum ChartValue: Sendable, Codable {
    case number(Double)
    case string(String)
    case date(Date)
    case null
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if container.decodeNil() {
            self = .null
        } else if let number = try? container.decode(Double.self) {
            self = .number(number)
        } else if let string = try? container.decode(String.self) {
            self = .string(string)
        } else if let date = try? container.decode(Date.self) {
            self = .date(date)
        } else {
            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Cannot decode ChartValue"
            )
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .number(let value):
            try container.encode(value)
        case .string(let value):
            try container.encode(value)
        case .date(let value):
            // Format as ISO8601 string for Chart.js
            let formatter = ISO8601DateFormatter()
            try container.encode(formatter.string(from: value))
        case .null:
            try container.encodeNil()
        }
    }
    
    /// Convert to JavaScript value string
    public var jsValue: String {
        switch self {
        case .number(let value):
            return String(value)
        case .string(let value):
            return "'\(value)'"
        case .date(let value):
            let formatter = ISO8601DateFormatter()
            return "'\(formatter.string(from: value))'"
        case .null:
            return "null"
        }
    }
}

// MARK: - ExpressibleByLiteral Conformances
extension ChartValue: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        self = .number(Double(value))
    }
}

extension ChartValue: ExpressibleByFloatLiteral {
    public init(floatLiteral value: Double) {
        self = .number(value)
    }
}

extension ChartValue: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self = .string(value)
    }
}

extension ChartValue: ExpressibleByNilLiteral {
    public init(nilLiteral: ()) {
        self = .null
    }
}