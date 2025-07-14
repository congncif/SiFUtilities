//
//  URL++.swift
//  SiFUtilities
//
//  Created by FOLY on 9/22/18.
//

import Foundation

public extension URL {
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

    func appending(parameters: [String: String]) -> URL {
        var url: URL = self
        if #available(iOS 16.0, *) {
            url = self.appending(queryItems: parameters.map { URLQueryItem(name: $0.key, value: $0.value) })
        } else {
            if var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: false) {
                var queryItems = urlComponents.queryItems ?? []
                for (key, value) in parameters {
                    queryItems.append(URLQueryItem(name: key, value: value))
                }
                urlComponents.queryItems = queryItems
                if let componentURL = urlComponents.url {
                    url = componentURL
                }
            }
        }
        return url
    }
}
