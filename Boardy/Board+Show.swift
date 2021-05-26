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
        if isLoading {
            rootViewController.showLoading(animated: animated)
        } else {
            rootViewController.hideLoading(animated: animated)
        }
    }

    func showErrorAlert(_ error: Error) {
        rootViewController.showErrorAlert(error)
    }
}
