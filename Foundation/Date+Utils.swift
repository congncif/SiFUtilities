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

extension Date {
    var calendar: Calendar { .current }

    public func dateAfterDays(_ days: Int) -> Date {
        return calendar.date(byAdding: .day, value: days, to: self)!
    }

    public var startOfDay: Date {
        return calendar.startOfDay(for: self)
    }

    public var endOfDay: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return calendar.date(byAdding: components, to: startOfDay)!
    }

    public var startOfWeek: Date {
        let sunday = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))!
        return calendar.date(byAdding: .day, value: 1, to: sunday)!
    }

    public var endOfWeek: Date {
        let sunday = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))!
        return sunday
    }

    public var startOfNextWeek: Date {
        return calendar.date(byAdding: .day, value: 7, to: self)!.startOfWeek
    }

    public var startOfMonth: Date! {
        let components = calendar.dateComponents([.year, .month], from: startOfDay)
        return calendar.date(from: components)!
    }

    public var endOfMonth: Date {
        var components = DateComponents()
        components.month = 1
        components.second = -1
        return calendar.date(byAdding: components, to: startOfMonth!)!
    }

    public var nextMonth: Date {
        return calendar.date(byAdding: .month, value: 1, to: self)!
    }

    public var previousMonth: Date {
        return calendar.date(byAdding: .month, value: -1, to: self)!
    }

    public var startOfNextMonth: Date {
        let firstDate = calendar.date(from: calendar.dateComponents([.year, .month], from: calendar.startOfDay(for: self)))!
        return calendar.date(byAdding: .month, value: 1, to: firstDate)!
    }

    public var startOfYear: Date {
        let components = calendar.dateComponents([.year], from: startOfDay)
        return calendar.date(from: components)!
    }

    public var endOfYear: Date {
        // Get the current year
        let year = calendar.component(.year, from: self)
        let firstOfNextYear = calendar.date(from: DateComponents(year: year + 1, month: 1, day: 1))!
        return calendar.date(byAdding: .day, value: -1, to: firstOfNextYear)!
    }

    public var nextYear: Date {
        return calendar.date(byAdding: .year, value: 1, to: self)!
    }

    public var previousYear: Date {
        return calendar.date(byAdding: .year, value: -1, to: self)!
    }
}

extension Date {
    public func isSameDate(_ comparisonDate: Date) -> Bool {
        let order = calendar.compare(self, to: comparisonDate, toGranularity: .day)
        return order == .orderedSame
    }

    public func isBeforeDate(_ comparisonDate: Date) -> Bool {
        let order = calendar.compare(self, to: comparisonDate, toGranularity: .day)
        return order == .orderedAscending
    }

    public func isAfterDate(_ comparisonDate: Date) -> Bool {
        let order = calendar.compare(self, to: comparisonDate, toGranularity: .day)
        return order == .orderedDescending
    }
}

extension Date {
    public var numberOfDaysInMonth: Int {
        let dateComponents = DateComponents(year: calendar.component(.year, from: self), month: calendar.component(.month, from: self))
        let date = calendar.date(from: dateComponents)!

        let range = calendar.range(of: .day, in: .month, for: date)!
        let numDays = range.count

        return numDays
    }
}

extension Date {
    public var age: Int {
        return calendar.dateComponents([.year], from: self, to: Date()).year!
    }
}
