//
//  PHViewController.swift
//  SiFUtilities_Example
//
//  Created by FOLY on 5/16/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import AVKit
import Foundation
import Photos
import PhotosUI
import UIKit

final class PHViewController: UIViewController {
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var urlLabel: UILabel!

    @IBAction private func chooseButtonDidTap() {
        showPhotosPicker()
    }

    @IBAction private func exportButtonDidTap() {}

    private func showPhotosPicker() {
        if #available(iOS 14, *) {
            let photoLibrary = PHPhotoLibrary.shared()
            var config = PHPickerConfiguration(photoLibrary: photoLibrary)
            config.selectionLimit = 2
            config.filter = .videos
            let picker = PHPickerViewController(configuration: config)
            picker.delegate = self
            present(picker, animated: true, completion: nil)
        } else {
            // Fallback on earlier versions
        }
    }
}

@available(iOS 14, *)
extension PHViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)

        for result in results {
            let itemProvider = result.itemProvider

            guard let typeIdentifier = itemProvider.registeredTypeIdentifiers.first,
                  let utType = UTType(typeIdentifier)
            else { continue }

            if utType.conforms(to: .image) {
                getPhoto(from: itemProvider, isLivePhoto: false)
            } else if utType.conforms(to: .movie) {
                getVideo(from: itemProvider, typeIdentifier: typeIdentifier)
            } else {
                getPhoto(from: itemProvider, isLivePhoto: true)
            }
        }
    }

    private func getPhoto(from itemProvider: NSItemProvider, isLivePhoto: Bool) {
        let objectType: NSItemProviderReading.Type = !isLivePhoto ? UIImage.self : PHLivePhoto.self

        if itemProvider.canLoadObject(ofClass: objectType) {
            itemProvider.loadObject(ofClass: objectType) { object, error in
                if let error = error {
                    print(error.localizedDescription)
                }

                if !isLivePhoto {
                    if let image = object as? UIImage {
                        DispatchQueue.main.async {
                            print("Photo: \(image)")
                        }
                    }
                } else {
                    if let livePhoto = object as? PHLivePhoto {
                        DispatchQueue.main.async {
                            print("Live Photo: \(livePhoto)")
                        }
                    }
                }
            }
        }
    }

    private func getVideo(from itemProvider: NSItemProvider, typeIdentifier: String) {
        itemProvider.loadFileRepresentation(forTypeIdentifier: typeIdentifier) { [weak self] url, error in
            if let error = error {
                print(error.localizedDescription)
            }

            guard let url = url else { return }

            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
            guard let targetURL = documentsDirectory?.appendingPathComponent(url.lastPathComponent) else { return }

            do {
                if FileManager.default.fileExists(atPath: targetURL.path) {
                    try FileManager.default.removeItem(at: targetURL)
                }

                try FileManager.default.copyItem(at: url, to: targetURL)
                
                print("video url: \(targetURL)")

                DispatchQueue.main.async {
                    let player = AVPlayer(url: targetURL)
                    let playerVC = AVPlayerViewController()
                    playerVC.player = player
                    self?.present(playerVC, animated: true, completion: nil)
                    playerVC.player?.play()
                }

            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
