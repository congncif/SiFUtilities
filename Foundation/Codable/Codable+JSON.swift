//
//  Codable+JSON.swift
//  
//
//  Created by NGUYEN CHI CONG on 12/18/20.
//

import Foundation

public struct JSONCodingKeys: CodingKey {
    public var stringValue: String

    public init?(stringValue: String) {
        self.stringValue = stringValue
    }

    public var intValue: Int?

    public init?(intValue: Int) {
        self.init(stringValue: "\(intValue)")
        self.intValue = intValue
    }
}

// MARK: - Decoding

extension Decoder {
    public func jsonContainer() throws -> KeyedDecodingContainer<JSONCodingKeys> {
        try container(keyedBy: JSONCodingKeys.self)
    }
}

extension KeyedDecodingContainer {
    public func decode(_ type: [String: Any].Type, forKey key: K) throws -> [String: Any] {
        let container = try self.nestedContainer(keyedBy: JSONCodingKeys.self, forKey: key)
        return try container.decode(type)
    }

    public func decodeIfPresent(_ type: [String: Any].Type, forKey key: K) throws -> [String: Any]? {
        guard contains(key) else {
            return nil
        }
        guard try decodeNil(forKey: key) == false else {
            return nil
        }
        return try self.decode(type, forKey: key)
    }

    public func decode(_ type: [Any].Type, forKey key: K) throws -> [Any] {
        var container = try self.nestedUnkeyedContainer(forKey: key)
        return try container.decode(type)
    }

    public func decodeIfPresent(_ type: [Any].Type, forKey key: K) throws -> [Any]? {
        guard contains(key) else {
            return nil
        }
        guard try decodeNil(forKey: key) == false else {
            return nil
        }
        return try self.decode(type, forKey: key)
    }

    public func decode(_: [String: Any].Type) throws -> [String: Any] {
        var dictionary = [String: Any]()

        for key in allKeys {
            if let boolValue = try? decode(Bool.self, forKey: key) {
                dictionary[key.stringValue] = boolValue
            } else if let stringValue = try? decode(String.self, forKey: key) {
                dictionary[key.stringValue] = stringValue
            } else if let intValue = try? decode(Int.self, forKey: key) {
                dictionary[key.stringValue] = intValue
            } else if let doubleValue = try? decode(Double.self, forKey: key) {
                dictionary[key.stringValue] = doubleValue
            } else if let nestedDictionary = try? decode([String: Any].self, forKey: key) {
                dictionary[key.stringValue] = nestedDictionary
            } else if let nestedArray = try? decode([Any].self, forKey: key) {
                dictionary[key.stringValue] = nestedArray
            }
        }
        return dictionary
    }
}

extension UnkeyedDecodingContainer {
    public mutating func decode(_: [Any].Type) throws -> [Any] {
        var array: [Any] = []
        while isAtEnd == false {
            // See if the current value in the JSON array is `null` first and prevent infite recursion with nested arrays.
            if try decodeNil() {
                continue
            } else if let value = try? decode(Bool.self) {
                array.append(value)
            } else if let value = try? decode(Double.self) {
                array.append(value)
            } else if let value = try? decode(String.self) {
                array.append(value)
            } else if let nestedDictionary = try? decode([String: Any].self) {
                array.append(nestedDictionary)
            } else if let nestedArray = try? decode([Any].self) {
                array.append(nestedArray)
            }
        }
        return array
    }

    public mutating func decode(_ type: [String: Any].Type) throws -> [String: Any] {
        let nestedContainer = try self.nestedContainer(keyedBy: JSONCodingKeys.self)
        return try nestedContainer.decode(type)
    }
}

// MARK: - Encoding

extension Encoder {
    public func jsonContainer() -> KeyedEncodingContainer<JSONCodingKeys> {
        container(keyedBy: JSONCodingKeys.self)
    }
}

extension KeyedEncodingContainer {
    public mutating func encode(_ value: [String: Any], forKey key: K) throws {
        var container = self.nestedContainer(keyedBy: JSONCodingKeys.self, forKey: key)
        return try container.encode(value)
    }

    public mutating func encode(_ value: [Any], forKey key: K) throws {
        var container = self.nestedUnkeyedContainer(forKey: key)
        return try container.encode(value)
    }

    public mutating func encode(_ value: [String: Any]) throws {
        try value.forEach { key, value in
            if let codingKey = JSONCodingKeys(stringValue: key) as? K {
                if let nestedDictionary = value as? [String: Any] {
                    try encode(nestedDictionary, forKey: codingKey)
                } else if let nestedArray = value as? [Any] {
                    try encode(nestedArray, forKey: codingKey)
                } else if let boolValue = value as? Bool {
                    try encode(boolValue, forKey: codingKey)
                } else if let stringValue = value as? String {
                    try encode(stringValue, forKey: codingKey)
                } else if let intValue = value as? Int {
                    try encode(intValue, forKey: codingKey)
                } else if let doubleValue = value as? Double {
                    try encode(doubleValue, forKey: codingKey)
                }
            }
        }
    }
}

extension UnkeyedEncodingContainer {
    public mutating func encode(_ value: [Any]) throws {
        try value.forEach { aValue in
            if let boolValue = aValue as? Bool {
                try encode(boolValue)
            } else if let stringValue = aValue as? String {
                try encode(stringValue)
            } else if let intValue = aValue as? Int {
                try encode(intValue)
            } else if let doubleValue = aValue as? Double {
                try encode(doubleValue)
            } else if let nestedDictionary = aValue as? [String: Any] {
                var nested = nestedContainer(keyedBy: JSONCodingKeys.self)
                try nested.encode(nestedDictionary)
            } else if let nestedArray = aValue as? [Any] {
                var nested = nestedUnkeyedContainer()
                try nested.encode(nestedArray)
            }
        }
    }
}
