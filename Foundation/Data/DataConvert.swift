//
//  DataConvert.swift
//  
//
//  Created by NGUYEN CHI CONG on 12/18/20.
//

import Foundation

extension String {
    public func data() -> Data? {
        data(using: .utf8)
    }

    public func jsonDictionary(encoding: String.Encoding = .utf8) -> [String: Any]? {
        data(using: encoding)?.jsonDictionary()
    }

    public func jsonArray(encoding: String.Encoding = .utf8) -> [Any]? {
        data(using: encoding)?.jsonArray()
    }
}

extension Data {
    public func string(encoding: String.Encoding = .utf8) -> String? {
        String(data: self, encoding: encoding)
    }

    public func jsonDictionary() -> [String: Any]? {
        try? JSONSerialization.jsonObject(with: self, options: []) as? [String: Any]
    }

    public func jsonArray() -> [Any]? {
        try? JSONSerialization.jsonObject(with: self, options: []) as? [Any]
    }
}

extension Array {
    public func jsonData() throws -> Data {
        try JSONSerialization.data(withJSONObject: self, options: [])
    }

    public func jsonString(encoding: String.Encoding = .utf8) -> String? {
        try? jsonData().string(encoding: encoding)
    }
}

extension Dictionary {
    public func jsonData() throws -> Data {
        try JSONSerialization.data(withJSONObject: self, options: [])
    }

    public func jsonString(encoding: String.Encoding = .utf8) -> String? {
        try? jsonData().string(encoding: encoding)
    }
}
