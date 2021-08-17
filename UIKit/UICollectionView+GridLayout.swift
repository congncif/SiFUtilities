//
//  UICollectionView+GridLayout.swift
//  SiFUtilities
//
//  Created by NGUYEN CHI CONG on 8/17/21.
//

import Foundation
import UIKit

public extension UICollectionView {
    func gridItemSize(numberOfColumns: Int) -> CGSize {
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let containerWidth = bounds.width

        let contentInsets = contentInset
        let sectionInsets = layout.sectionInset

        let totalInsetsHorizontalSpace = contentInsets.left + contentInsets.right + sectionInsets.left + sectionInsets.right

        let columns = CGFloat(numberOfColumns)
        let width = (containerWidth - totalInsetsHorizontalSpace - (columns - 1) * layout.minimumInteritemSpacing) / columns
        let height = width
        let calculatedItemSize = CGSize(width: width, height: height)

        return calculatedItemSize
    }
}
