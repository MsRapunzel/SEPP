//
//  LocalFileManager.swift
//  CryptoiOS
//
//  Created by Anastasiia Zolotova on 24.04.2024.
//

import Foundation
import SwiftUI

/// `LocalFileManager` is a singleton class responsible for managing the local file system operations
/// such as saving and retrieving images within a specific folder in the caches directory.
class LocalFileManager {
    
    /// The shared instance of `LocalFileManager`.
    static let instance = LocalFileManager()
    
    /// Private initializer to ensure only one instance of the class is created.
    private init() {}
    
    /// Saves a `UIImage` to the specified folder with the given image name.
    ///
    /// This method creates the folder if it doesn't exist, then saves the image as a PNG file.
    ///
    /// - Parameters:
    ///   - image: The `UIImage` to be saved.
    ///   - imageName: The name to be assigned to the saved image file.
    ///   - folderName: The name of the folder where the image should be saved.
    func saveImage(image: UIImage, imageName: String, folderName: String) {
        
        // Create the folder if it doesn't exist
        createFolderIfNeeded(folderName: folderName)
        
        // Get the URL path for the image
        guard
            let data = image.pngData(),
            let url = getURLForImage(imageName: imageName, folderName: folderName)
            else { return }
        
        // Save the image to the path
        do {
            try data.write(to: url)
        } catch let error {
            print("Error saving image. ImageName: \(imageName). \(error)")
        }
    }
    
    /// Retrieves a `UIImage` from the specified folder with the given image name.
    ///
    /// - Parameters:
    ///   - imageName: The name of the image file to retrieve.
    ///   - folderName: The name of the folder where the image is stored.
    /// - Returns: The `UIImage` if it exists, otherwise `nil`.
    func getImage(imageName: String, folderName: String) -> UIImage? {
        guard
            let url = getURLForImage(imageName: imageName, folderName: folderName),
            FileManager.default.fileExists(atPath: url.path) else {
            return nil
        }
        return UIImage(contentsOfFile: url.path)
    }
    
    /// Creates a folder with the specified name if it doesn't already exist.
    ///
    /// - Parameter folderName: The name of the folder to create.
    private func createFolderIfNeeded(folderName: String) {
        guard let url = getURLForFolder(folderName: folderName) else { return }
        
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            } catch let error {
                print("Error creating directory. FolderName: \(folderName). \(error)")
            }
        }
    }
    
    /// Returns the URL for the specified folder in the caches directory.
    ///
    /// - Parameter folderName: The name of the folder.
    /// - Returns: The URL of the folder if it can be determined, otherwise `nil`.
    private func getURLForFolder(folderName: String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }
        return url.appendingPathComponent(folderName)
    }
    
    /// Returns the URL for the specified image within a folder.
    ///
    /// - Parameters:
    ///   - imageName: The name of the image file.
    ///   - folderName: The name of the folder.
    /// - Returns: The URL of the image file if it can be determined, otherwise `nil`.
    private func getURLForImage(imageName: String, folderName: String) -> URL? {
        guard let folderURL = getURLForFolder(folderName: folderName) else {
            return nil
        }
        return folderURL.appendingPathComponent(imageName + ".png")
    }
    
}
