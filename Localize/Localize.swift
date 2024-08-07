//
//  Common.swift
//  SiFUtilities
//
//  Created by FOLY on 2/4/17.
//  Copyright © 2017 [iF] Solution. All rights reserved.
//

import Foundation
import Localize_Swift

struct RunTimeKey {
    static var localizedTextKey: UInt8 = 0
    static var localizedPlaceholderTextKey: UInt8 = 1
    static var localizedImageNameKey: UInt8 = 3
    static var localizedNormalTitleKey: UInt8 = 4
    static var localizedSelectedTitleKey: UInt8 = 5
    static var localizedTitleKey: UInt8 = 6
    static var localizedBackTitleKey: UInt8 = 7
    static var localizedArrayKey: UInt8 = 8
}

public typealias LocalizedKey = UInt8

public extension LocalizedKey {
    static let localizedTextKey: UInt8 = 0
    static let localizedPlaceholderTextKey: UInt8 = 1
    static let localizedImageNameKey: UInt8 = 3
    static let localizedNormalTitleKey: UInt8 = 4
    static let localizedSelectedTitleKey: UInt8 = 5
    static let localizedTitleKey: UInt8 = 6
    static let localizedBackTitleKey: UInt8 = 7
    static let localizedArrayKey: UInt8 = 8
}

public func LocalizedString(_ string: String, tableName: String? = nil) -> String {
    return NSLocalizedString(string, tableName: tableName, comment: string)
}

public protocol Localizable {
    var localized: String { get }
}

extension String: Localizable {
    public var localized: String {
        return localized()
    }
}

@objc protocol LocalizeRenderable: AnyObject {
    func registerLocalizeUpdateNotification()
    func unregisterLocalizeUpdateNotification()

    func updateLocalize(attributes: [LocalizedKey: String])
    func updateLanguage()
}

extension NSObject: LocalizeRenderable {
    @objc open func registerLocalizeUpdateNotification() {
        unregisterLocalizeUpdateNotification()

        NotificationCenter.default.addObserver(self, selector: #selector(updateLanguage), name: Notification.Name(rawValue: LCLLanguageChangeNotification), object: nil)
    }

    @objc open func unregisterLocalizeUpdateNotification() {
        NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: LCLLanguageChangeNotification), object: nil)
    }

    @objc open func updateLocalize(attributes: [LocalizedKey: String]) {}

    @objc open func updateLanguage() {}
}

extension AssociatedObject where Self: NSObject {
    func getStringValue(by runtimeKey: inout UInt8) -> String? {
        return getAssociatedObject(key: &runtimeKey)
    }

    func setStringValue(_ newValue: String?, forRuntimeKey key: inout UInt8) {
        setAssociatedObject(key: &key, value: newValue)

        let altKey = key
        if let value = newValue, !value.isEmpty {
            registerLocalizeUpdateNotification()
            updateLocalize(attributes: [altKey: value])
        } else {
            unregisterLocalizeUpdateNotification()
        }
    }
}
