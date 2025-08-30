import Foundation

/// Configuration for how users interact with the chart
public struct InteractionOptions: Sendable {
    public let mode: InteractionMode?
    public let intersect: Bool?
    public let axis: InteractionAxis?
    public let includeInvisible: Bool?
    
    public init(
        mode: InteractionMode? = .nearest,
        intersect: Bool? = true,
        axis: InteractionAxis? = nil,
        includeInvisible: Bool? = false
    ) {
        self.mode = mode
        self.intersect = intersect
        self.axis = axis
        self.includeInvisible = includeInvisible
    }
    
    func toDictionary() -> [String: Any] {
        var dict: [String: Any] = [:]
        
        if let mode = mode {
            dict["mode"] = mode.rawValue
        }
        if let intersect = intersect {
            dict["intersect"] = intersect
        }
        if let axis = axis {
            dict["axis"] = axis.rawValue
        }
        if let includeInvisible = includeInvisible {
            dict["includeInvisible"] = includeInvisible
        }
        
        return dict
    }
}

/// Interaction modes determine which elements are affected by interactions
public enum InteractionMode: String, Sendable {
    case point
    case nearest
    case index
    case dataset
    case x
    case y
}

/// Which axes to consider for interactions
public enum InteractionAxis: String, Sendable {
    case x
    case y
    case xy
    case r
}