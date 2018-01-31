//
//  Date+Utils.swift
//  Meeting Up
//
//  Created by FOLY on 2/4/17.
//  Copyright © 2017 Julian Heissl. All rights reserved.
//

import Foundation

extension Date {
    public var age: Int {
        return Calendar.current.dateComponents([.year], from: self, to: Date()).year!
    }
}

//////////////////////////////////////////////////////////////////////////////////////

extension Date {
    public func toString(format: String? = "dd-MM-yyyy", timeZone: TimeZone = TimeZone(secondsFromGMT: 0)!) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timeZone
        let internalFormat = format
        dateFormatter.dateFormat = internalFormat
        
        return dateFormatter.string(from: self)
    }
}
