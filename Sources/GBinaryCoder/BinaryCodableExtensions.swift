/// Implementations of BinaryCodable for built-in types.

import Foundation

public protocol FixedSizeArray: BinaryCodable, Equatable {
    static var size: Int { get }
    var data: [UInt8] { get set }
    init()
}

extension FixedSizeArray {
    
    public subscript(_ index: Int) -> UInt8 {
        data[index]
    }

}

extension FixedSizeArray where Self: BinaryDecodable {
    
    public init(fromBinary decoder: BinaryDecoder) throws {
        self.init()
        
        data = [UInt8]()
        for _ in 0..<Self.size {
            let decoded = try UInt8(from: decoder)
            data.append(decoded)
        }
        // because we use the little-endian format
        data.reverse()
    }

}

extension FixedSizeArray where Self: BinaryEncodable {
    
    public func binaryEncode(to encoder: BinaryEncoder) throws {
        let littleEndianFormattedData = Array(data.reversed())
        for index in 0..<Self.size {
            let element = index < littleEndianFormattedData.count ? littleEndianFormattedData[index] : 0
            try element.encode(to: encoder)
        }
    }
    
}

extension Array: BinaryEncodable where Element: Encodable {
    
    public func binaryEncode(to encoder: BinaryEncoder) throws {
        try encoder.encode(self.count)
        for element in self {
            try element.encode(to: encoder)
        }
    }
    
}

extension Array: BinaryDecodable where Element: Decodable {
    
    public init(fromBinary decoder: BinaryDecoder) throws {
        
        let count = try decoder.decode(Int.self)
        self.init()
        self.reserveCapacity(count)
        
        for _ in 0..<count {
            let decoded = try Element(from: decoder)
            self.append(decoded)
        }
    }
    
}

extension String: BinaryCodable {
    
    public func binaryEncode(to encoder: BinaryEncoder) throws {
        encoder.appendBytes(of: [UInt8](self.utf8))
    }
    
    public init(fromBinary decoder: BinaryDecoder) throws {
        self = try decoder.decode(String.self)
    }
    
}

extension FixedWidthInteger where Self: BinaryEncodable {
    
    public func binaryEncode(to encoder: BinaryEncoder) {
        encoder.appendBytes(of: self.littleEndian)
    }
    
}

extension FixedWidthInteger where Self: BinaryDecodable {
    
    public init(fromBinary binaryDecoder: BinaryDecoder) throws {
        var integer = Self()
        try binaryDecoder.read(into: &integer)
        self.init(littleEndian: integer)
    }
    
}

extension Int8: BinaryCodable {}
extension UInt8: BinaryCodable {}
extension Int16: BinaryCodable {}
extension UInt16: BinaryCodable {}
extension Int32: BinaryCodable {}
extension UInt32: BinaryCodable {}
extension Int64: BinaryCodable {}
extension UInt64: BinaryCodable {}

