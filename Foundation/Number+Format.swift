//
//  Number+Format.swift
//  SiFUtilities
//
//  Created by NGUYEN CHI CONG on 8/17/21.
//

import Foundation

extension Numeric {
    public func formatted(separator: String? = nil,
                          numberStyle: NumberFormatter.Style = .decimal,
                          localeIdentifier: String? = "vn_VN") -> String {
        var locale = Locale.current
        if let localeID = localeIdentifier {
            locale = Locale(identifier: localeID)
        }

        let separator = separator ?? locale.decimalSeparator ?? ","
        let formatter = NumberFormatter(separator: separator, numberStyle: numberStyle)
        formatter.locale = locale

        return formatter.string(for: self) ?? "\(self)"
    }
}

extension NumberFormatter {
    public convenience init(separator: String, numberStyle: NumberFormatter.Style) {
        self.init()
        self.usesGroupingSeparator = true
        self.groupingSize = 3
        self.currencyGroupingSeparator = separator
        self.groupingSeparator = separator
        self.numberStyle = numberStyle
    }
}

extension Locale {
    public static var vietnam: Locale {
        return Locale(identifier: "vn_VN")
    }
}
