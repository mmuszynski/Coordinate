// The Swift Programming Language
// https://docs.swift.org/swift-book
//
//  Coordinate.swift
//  Advent2023
//
//  Created by Mike Muszynski on 12/12/23.
//

import Foundation

public struct Coordinate: Hashable, ExpressibleByStringLiteral, Sendable {
    public var x: Int
    public var y: Int
    
    public var row: Int {
        get {
            return y
        }
        set {
            y = newValue
        }
    }
    
    public var col: Int {
        get {
            return x
        }
        set {
            x = newValue
        }
    }
    
    @available(*, deprecated: 0, renamed: "reversed")
    var flipped: Coordinate {
        Coordinate(x: -self.x, y: -self.y)
    }
    
    var reversed: Coordinate {
        Coordinate(x: -self.x, y: -self.y)
    }
    
    public init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
    
    public init(row: Int, col: Int) {
        self.init(x: col, y: row)
    }
    
    public init(stringLiteral value: StringLiteralType) {
        let values = value
            .components(separatedBy: .whitespaces)
            .joined()
            .components(separatedBy: ",")
            .compactMap { Int($0) }
        self.init(x: values[0],
                  y: values[1])
    }
    
    public func advancing(x: Int, y: Int) -> Coordinate {
        Coordinate(x: self.x + x, y: self.y + y)
    }
    
    func distance(from other: Coordinate) -> Int {
        return abs(other.x - self.x) + abs(other.y - self.y)
    }
}

extension Coordinate: AdditiveArithmetic {
    public static var zero: Coordinate {
        Coordinate(x: 0, y: 0)
    }
    
    public static func + (lhs: Coordinate, rhs: Coordinate) -> Coordinate {
        Coordinate(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
    
    public static func - (lhs: Coordinate, rhs: Coordinate) -> Coordinate {
        Coordinate(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }
}

extension Coordinate {
    public static func * (lhs: Coordinate, rhs: Int) -> Coordinate {
        return Coordinate(x: lhs.x * rhs, y: lhs.y * rhs)
    }
    
    public static func * (lhs: Int, rhs: Coordinate) -> Coordinate {
        return rhs * lhs
    }
    
    public static func / (lhs: Coordinate, rhs: Int) -> Coordinate {
        return lhs * (1 / rhs)
    }
}

/// Allows for addition of direction
extension Coordinate {
    static prefix func - (coordinate: Coordinate) -> Coordinate {
        return coordinate.flipped
    }
}

extension Coordinate: CustomStringConvertible {
    public var description: String {
        "{ \(x), \(y) }"
    }
}

extension Coordinate {
    static let up: Coordinate = "0,-1"
    static let right: Coordinate = "1,0"
    static let down: Coordinate = "0,1"
    static let left: Coordinate = "-1,0"
    
    static let north: Coordinate = .up
    static let east: Coordinate = .right
    static let south: Coordinate = .down
    static let west: Coordinate = .left
    
    static let northEast: Coordinate = .north + .east
    static let southEast: Coordinate = .south + .east
    static let southWest: Coordinate = .south + .west
    static let northWest: Coordinate = .north + .west

    static let cardinalDirections: [Coordinate] = [.up, .right, .left, .down]
    static let intermediateDirections: [Coordinate] = [.northEast, .southEast, .southWest, .northWest]
    static let cardinalAndIntermediateDirections: [Coordinate] = cardinalDirections + intermediateDirections
}
