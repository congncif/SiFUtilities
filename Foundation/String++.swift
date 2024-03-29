//
//  String++.swift
//  SiFUtilities
//
//  Created by FOLY on 1/11/17.
//  Copyright © 2017 [iF] Solution. All rights reserved.
//

import Foundation

// MARK: - ID

extension String {
    public static func random(length: Int = 16) -> String {
        let letters: NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        
        var randomString = String()
        
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        
        return randomString
    }
    
    public static func uuid() -> String {
        return UUID().uuidString
    }
    
    public static func uniqueIdentifier() -> String {
        return self.uuid().lowercased()
    }
}

// MARK: - Date

extension String {
    public func toDate(format: String? = DateFormat.detailRegular,
                       timeZone: TimeZone? = .current) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timeZone
        let internalFormat = format
        dateFormatter.dateFormat = internalFormat
        
        return dateFormatter.date(from: self)
    }
}

// MARK: - Transform

extension String {
    public var trimmingWhiteSpaces: String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    public func removingCharacters(_ characters: CharacterSet) -> String {
        return components(separatedBy: characters).joined()
    }
    
    public var removingWhiteSpaces: String {
        return self.removingCharacters(.whitespacesAndNewlines)
    }
    
    public var words: [String] {
        return components(separatedBy: .punctuationCharacters)
            .joined()
            .components(separatedBy: .whitespaces)
            .filter { !$0.isEmpty }
    }
    
    public var replacingWhiteSpacesByNonbreakingSpaces: String {
        return replacingOccurrences(of: " ", with: "\u{00a0}")
    }
    
    public var capitalizingFirstLetter: String {
        return prefix(1).uppercased() + dropFirst()
    }
    
    public var lowercasingFirstLetter: String {
        return prefix(1).lowercased() + dropFirst()
    }
    
    public mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter
    }
    
    public mutating func lowercaseFirstLetter() {
        self = self.lowercasingFirstLetter
    }
    
    public func snakeCased() -> String {
        let pattern = "([a-z0-9])([A-Z])"
        
        let regex = try? NSRegularExpression(pattern: pattern, options: [])
        let range = NSRange(location: 0, length: self.count)
        return regex?.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: "$1_$2").lowercased() ?? self
    }
    
    public func camelCased(separator: String = "_", skipFirstLetter: Bool = true) -> String {
        let components = self.components(separatedBy: separator)
        var newComponents: [String] = []
        
        for (idx, word) in components.enumerated() {
            if idx == 0, skipFirstLetter {
                newComponents.append(word.lowercased())
            } else {
                newComponents.append(word.lowercased().capitalizingFirstLetter)
            }
        }
        
        if newComponents.count <= 1 {
            return self
        }
        
        return newComponents.joined()
    }
}

// MARK: - Checking

extension String {
    public var isAlphanumerics: Bool {
        return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
    
    public var digitsOnly: String {
        return replacingOccurrences(of: "[^\\d+]", with: "", options: [.regularExpression])
    }
    
    public func insensitiveContains(_ subString: String) -> Bool {
        return range(of: subString, options: [.caseInsensitive, .diacriticInsensitive]) != nil
    }
}

// MARK: - Format

extension String {
    public func formatted(defaultAttributes: [NSAttributedString.Key: Any], attributedStrings: NSAttributedString...) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self, attributes: defaultAttributes)
        for subString in attributedStrings {
            let range = (self as NSString).range(of: subString.string)
            attributedString.replaceCharacters(in: range, with: subString)
        }
        return attributedString
    }
}
