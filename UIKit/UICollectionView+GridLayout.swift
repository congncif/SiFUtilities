//
//  UICollectionView+GridLayout.swift
//  SiFUtilities
//
//  Created by NGUYEN CHI CONG on 8/17/21.
//

import CoreGraphics
import Foundation
import UIKit

public extension UICollectionView {
    func gridItemSize(numberOfColumns: Int, heightWidthRatio: CGFloat) -> CGSize {
        let guardRatio = heightWidthRatio == 0 ? 1 : heightWidthRatio
        return gridItemSize(numberOfColumns: numberOfColumns, ratio: 1 / guardRatio)
    }

    /// Parameter: ratio equals width / height, default is 1
    func gridItemSize(numberOfColumns: Int, ratio: CGFloat = 1) -> CGSize {
        let guardRatio = ratio == 0 ? 1 : ratio

        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else {
            assertionFailure("‼️ The current layout is of type \(type(of: collectionViewLayout)) but the function gridItemSize(numberOfColumns:ratio:) only apply for type UICollectionViewFlowLayout.")
            return .zero
        }
        layout.estimatedItemSize = .zero

        let containerWidth = bounds.width
        let contentInsets = contentInset
        let sectionInsets = layout.sectionInset

        let totalInsetsHorizontalSpace = contentInsets.left + contentInsets.right + sectionInsets.left + sectionInsets.right

        let columns = CGFloat(numberOfColumns)
        let width = (containerWidth - totalInsetsHorizontalSpace - (columns - 1) * layout.minimumInteritemSpacing) / columns
        let height = width / guardRatio
        let calculatedItemSize = CGSize(width: width, height: height)

        return calculatedItemSize
    }
}
