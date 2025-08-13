//
//  URL++.swift
//  SiFUtilities
//
//  Created by FOLY on 9/22/18.
//

import Foundation

public extension URL {
    @available(*, deprecated, message: "Use queryParameters instead of")
    var keyValueParameters: [String: String]? {
        guard let keyValues = query?.components(separatedBy: "&") else {
            return nil
        }
        var results = [String: String]()
        if keyValues.count > 0 {
            for pair in keyValues {
                let kv = pair.components(separatedBy: "=")
                if kv.count > 1 {
                    results.updateValue(kv[1], forKey: kv[0])
                }
            }
        }
        return results
    }

    var queryParameters: [String: String] {
        if let components = URLComponents(url: self, resolvingAgainstBaseURL: true),
           let queryItems = components.queryItems {
            queryItems.reduce(into: [:]) { partialResult, item in
                partialResult[item.name] = item.value?.removingPercentEncoding
            }
        } else {
            [:]
        }
    }
    
    func appending(queryItem name: String, value: String?) -> URL {
        guard var components = URLComponents(url: self, resolvingAgainstBaseURL: false) else {
            return self
        }
        
        var queryItems = components.queryItems ?? []
        queryItems.append(URLQueryItem(name: name, value: value))
        components.queryItems = queryItems
        
        return components.url ?? self
    }
    
    func appending(queryItems: [String: String?]) -> URL {
        guard var components = URLComponents(url: self, resolvingAgainstBaseURL: false) else {
            return self
        }
        
        var existingItems = components.queryItems ?? []
        for (name, value) in queryItems {
            existingItems.append(URLQueryItem(name: name, value: value))
        }
        components.queryItems = existingItems
        
        return components.url ?? self
    }
    
    func replacing(queryItem name: String, value: String?) -> URL {
        guard var components = URLComponents(url: self, resolvingAgainstBaseURL: false) else {
            return self
        }
        
        // Filter out existing items with the same name
        var queryItems = components.queryItems?.filter { $0.name != name } ?? []
        // Add the new item
        queryItems.append(URLQueryItem(name: name, value: value))
        components.queryItems = queryItems
        
        return components.url ?? self
    }
    
    func replacing(queryItems: [String: String?]) -> URL {
        guard var components = URLComponents(url: self, resolvingAgainstBaseURL: false) else {
            return self
        }
        
        var queryItemsArray = components.queryItems ?? []
        
        for (name, value) in queryItems {
            // Remove any existing item with same name
            queryItemsArray.removeAll { $0.name == name }
            // Add the new one
            queryItemsArray.append(URLQueryItem(name: name, value: value))
        }
        
        components.queryItems = queryItemsArray
        return components.url ?? self
    }
}
