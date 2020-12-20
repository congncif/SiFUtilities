//
//  JSONCodable.swift
//  
//
//  Created by NGUYEN CHI CONG on 12/18/20.
//

import Foundation

public protocol JSONDecodable {
    init(from jsonData: Data) throws
    init(from jsonString: String) throws
}

public protocol JSONEncodable {
    func encodeData() throws -> Data
}

public extension JSONDecodable where Self: Decodable {
    init(from jsonData: Data) throws {
        self = try JSONDecoder().decode(Self.self, from: jsonData)
    }

    init(from jsonString: String) throws {
        guard let data = jsonString.data() else {
            throw NSError(domain: "JSONDecodable.jsonString.invalid", code: 0, userInfo: [NSLocalizedDescriptionKey: "Cannot convert json string to data"])
        }
        try self.init(from: data)
    }
}

public extension JSONEncodable where Self: Encodable {
    func encodeData() throws -> Data {
        try JSONEncoder().encode(self)
    }
}
