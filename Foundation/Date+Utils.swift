//
//  Date+Utils.swift
//  SiFUtilities
//
//  Created by FOLY on 2/4/17.
//  Copyright © 2017 [iF] Solution. All rights reserved.
//

import Foundation

public enum DateFormat {
    public static let regular1 = "dd/MM/yyyy"
    public static let regular2 = "MM/dd/yyyy"
    public static let regular3 = "yyyy/MM/dd"

    public static let simple1 = "dd-MM-yyyy"
    public static let simple2 = "MM-dd-yyyy"
    public static let simple3 = "yyyy-MM-dd"

    public static let simpleDot1 = "dd.MM.yyyy"
    public static let simpleDot2 = "MM.dd.yyyy"
    public static let simpleDot3 = "yyyy.MM.dd"

    public static let shortMonth = "MMM dd, yyyy"
    public static let longMonth = "MMMMM dd, yyyy"

    public static let detailSimple = "dd-MMM-yyyy HH:mm"
    public static let detailSimpleH = "dd-MM-yyyy HH'h'mm"
    public static let detailSimpleHMin = "dd-MM-yyyy HH'h'MM'min'"

    public static let detailRegular = "dd/MM/yyyy HH:mm"
    public static let detailRegularH = "dd/MM/yyyy HH'h'mm"
    public static let detailRegularZ = "dd/MM/yyyy HH:mm zzz"
    public static let detailRegularAZ = "dd/MM/yyyy hh:mm a zzz"
    public static let detailRegularS = "dd/MM/yyyy HH:mm:ss"
    public static let detailRegularSZ = "dd/MM/yyyy HH:mm:ss zzz"
    public static let detailRegularSAZ = "dd/MM/yyyy hh:mm:ss a zzz"

    public static let detailLongMonthAZ = "MMMMM dd, yyyy hh:mm a zzz"
}

extension TimeZone {
    public static var gmt: TimeZone {
        TimeZone(secondsFromGMT: 0) ?? .current
    }
}

extension Date {
    public func age() -> Int? {
        return Calendar.current.dateComponents([.year], from: self, to: Date()).year
    }
}

extension Date {
    public func toString(format: String? = DateFormat.detailRegular,
                         timeZone: TimeZone? = .current) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timeZone
        let internalFormat = format
        dateFormatter.dateFormat = internalFormat

        return dateFormatter.string(from: self)
    }

    public var localDateFromGMT: Date {
        let timezone = TimeZone.current
        let seconds = timezone.secondsFromGMT(for: self)
        return Date(timeInterval: TimeInterval(seconds), since: self)
    }

    public var gmtDateFromLocal: Date {
        let timezone = TimeZone.current
        let seconds = timezone.secondsFromGMT(for: self)
        return Date(timeInterval: TimeInterval(-seconds), since: self)
    }
}
