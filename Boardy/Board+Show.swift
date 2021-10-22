//
//  Board+Show.swift
//  SiFUtilities
//
//  Created by NGUYEN CHI CONG on 5/26/21.
//

import Boardy
import Foundation

public extension ActivatableBoard where Self: InstallableBoard {
    func showDefaultLoading(_ isLoading: Bool, animated: Bool = true) {
        guard context != nil else {
            #if DEBUG
            print("⚠️ \(#function) did perform without the context")
            #endif
            return
        }
        if isLoading {
            rootViewController.showLoading(animated: animated)
        } else {
            rootViewController.hideLoading(animated: animated)
        }
    }

    func showErrorAlert(_ error: Error) {
        guard context != nil else {
            #if DEBUG
            print("⚠️ \(#function) with error \(error) did perform without the context")
            #endif
            return
        }
        rootViewController.showErrorAlert(error)
    }
}
