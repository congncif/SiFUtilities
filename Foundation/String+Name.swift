//
//  String+Name.swift
//  
//
//  Created by NGUYEN CHI CONG on 12/25/20.
//

import Foundation

extension String {
    public static func moduleName(for anClass: AnyClass) -> String {
        guard let name = String(reflecting: anClass).split(separator: ".").first else {
            assertionFailure("You are in this case because Swift.String(reflecting:) API was broken. Will fallback to subject name in release configuration.")
            return String(describing: anClass)
        }
        return String(name)
    }
}
