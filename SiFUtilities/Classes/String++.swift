//
//  String++.swift
//  SiFUtilities
//
//  Created by FOLY on 1/11/17.
//  Copyright © 2017 [iF] Solution. All rights reserved.
//

import Foundation

extension String {
    public static func random(length: Int = 10) -> String {
        let letters: NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        
        return randomString
    }
    
    /**
     * Create regex to search results contain one sub pattern at least
     * Eg: "abc,Abc,ABC".containOneAtLeastRegex(",")
     */
    public func containOneAtLeastRegex(separatedBy: String? = nil) -> String {
        let searchTags = separatedBy == nil ? [self] : self.components(separatedBy: separatedBy!)
        var regex = ".*("
        for tag in searchTags {
            regex += tag
            if tag != searchTags.last {
                regex += "|"
            }
        }
        regex += ").*"
        
        return regex
    }
    
    public func toDate(format: String? = "dd-MM-yyyy", timeZone: TimeZone = TimeZone(secondsFromGMT: 0)!) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timeZone
        let internalFormat = format
        dateFormatter.dateFormat = internalFormat
        
        return dateFormatter.date(from: self)
    }
    
    public var trimmingWhiteSpaces: String {
        let string = self as NSString
        let trimmedString = string.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        return trimmedString
    }
    
    public var words: [String] {
        return components(separatedBy: .punctuationCharacters)
            .joined()
            .components(separatedBy: .whitespaces)
            .filter { !$0.isEmpty }
    }
}
