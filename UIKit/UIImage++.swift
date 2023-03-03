//
//  UIImage++.swift
//  SiFUtilities
//
//  Created by FOLY on 9/22/18.
//

import Foundation
import UIKit

// MARK: - UIImage from color

extension UIImage {
    public class func image(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
}

// MARK: - UIImage Compression

public enum ImageCompressionType {
    case jpeg(quality: Double)
    case png
}

public extension UIImage {
    func compressedData(type: ImageCompressionType = .jpeg(quality: 0.33), boundary: CGFloat? = 1280) -> Data? {
        let size = self.fittedSize(boundary: boundary)
        let resizedImage = boundary == nil ? self : self.resized(targetSize: size)
        var data: Data?
        switch type {
        case let .jpeg(quality):
            data = resizedImage?.jpegData(compressionQuality: quality)
        case .png:
            data = resizedImage?.pngData()
        }
        return data
    }
    
    func compressedIfNeeded(type: ImageCompressionType = .jpeg(quality: 0.33), boundary: CGFloat? = 1280) -> UIImage {
        guard let data = compressedData(type: type, boundary: boundary) else {
            print("⚠️ Image Compression failed ➤ Return original image")
            return self
        }
        
        guard let image = UIImage(data: data) else {
            #if DEBUG
            print("⚠️ Image Compression cannot render new image ➤ Return original image")
            #endif
            return self
        }
        
        return image
    }
    
    /**
     Zoom the picture to the specified size
     - parameter newSize: image size
     - returns: new image
     */
    func resized(targetSize: CGSize) -> UIImage? {
        let newRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        var newImage: UIImage?
        UIGraphicsBeginImageContext(newRect.size)
        newImage = UIImage(cgImage: self.cgImage!, scale: 1, orientation: self.imageOrientation)
        newImage?.draw(in: newRect)
        newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    private func fittedSize(boundary: CGFloat?) -> CGSize {
        var width = self.size.width
        var height = self.size.height
        
        guard let boundary = boundary else {
            return CGSize(width: width, height: height)
        }
        
        // width, height <= boundary, Size remains the same
        guard width > boundary || height > boundary else {
            return CGSize(width: width, height: height)
        }
        
        // aspect ratio
        let s = max(width, height) / min(width, height)
        if s <= 2 {
            // Set the larger value to the boundary, the smaller the value of the compression
            let x = max(width, height) / boundary
            if width > height {
                width = boundary
                height = height / x
            } else {
                height = boundary
                width = width / x
            }
        } else {
            // width, height > boundary
            if min(width, height) >= boundary {
                // Set the smaller value to the boundary, and the larger value is compressed
                let x = min(width, height) / boundary
                if width < height {
                    width = boundary
                    height = height / x
                } else {
                    height = boundary
                    width = width / x
                }
            }
        }
        return CGSize(width: width, height: height)
    }
}
