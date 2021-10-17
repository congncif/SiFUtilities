//
//  UICollectionViewCell++.swift
//  SiFUtilities
//
//  Created by NGUYEN CHI CONG on 10/17/21.
//

import UIKit

public extension UICollectionView {
    func register<Cell: UICollectionViewCell>(_ nibCellType: Cell.Type) {
        let identifier = String(describing: Cell.self)
        let nib = UINib(nibName: identifier, bundle: Bundle(for: Cell.self))
        self.register(nib, forCellWithReuseIdentifier: identifier)
    }

    func dequeueReusableCell<Cell: UICollectionViewCell>(_ cellType: Cell.Type = Cell.self, at indexPath: IndexPath) -> Cell {
        let identifier = String(describing: Cell.self)
        let dequeueCell = self.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        guard let cell = dequeueCell as? Cell else {
            preconditionFailure("‼️ Type of cell is incorrect. Expected type is \(identifier) but got \(type(of: dequeueCell)).")
        }
        return cell
    }
}
