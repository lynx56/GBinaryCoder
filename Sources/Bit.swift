//
//  Bit.swift
//  R4SScales
//
//  Created by Gulnaz on 25.01.2021.
//

import Foundation

public enum Bit: UInt8, CustomStringConvertible {
    case zero, one

    public var description: String {
        switch self {
        case .one:
            return "1"
        case .zero:
            return "0"
        }
    }
}

public extension Array where Element == Bit {
    init(fromByte byte: UInt8) {
        var byte = byte
        var bits = [Bit](repeating: .zero, count: 8)
        for i in 0..<8 {
            let currentBit = byte & 0x01
            if currentBit != 0 {
                bits[i] = .one
            }

            byte >>= 1
        }

        self = bits
    }
    
    var byte: UInt8 {
        return self.reduce(0) { accumulated, current in
            accumulated << 1 | (current == .one ? 1 : 0)
        }
    }
}
