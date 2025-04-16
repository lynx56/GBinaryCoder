//
//  UInt32+read.swift
//  BinaryCoder
//
//  Created by Holyberry on 29.07.2021.
//

import Foundation

public extension UInt32 {
    
    func read(startBit: UInt8, bits count: UInt8) -> UInt32 {
        let mask: UInt32 = UInt32((1 << (count - 1)) - 1)
        return (self >> startBit) & mask
    }
    
    func read(bit: UInt8) -> Bool {
        let mask: UInt32 = (1 << 1) - 1
        return ((self >> bit) & mask) > 0
    }
    
}
