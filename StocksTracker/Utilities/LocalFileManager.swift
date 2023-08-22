//
//  LocalFileManager.swift
//  PaperCoin
//
//  Created by KAARTHIKEYA K on 22/08/23.
//

import Foundation
import SwiftUI

class LocalFileManager {
    
    static let shared = LocalFileManager()
    
    private init(){ }
    
    // Save Images to the File Manager
    
    func saveImage(imageName: String, folderName: String, image: UIImage) {
        
        guard let data = image.pngData(),
              let url = getURLForImage(imageName: imageName, folderName: folderName)
        else {return}
        
        
        do {
            try data.write(to: url)
        } catch let error {
            print("Error saving Image:. \(error)")
        }
    }
    
    private func getURLForFolder(folderName: String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }
        return url.appendingPathComponent(folderName)
    }
    
    private func getURLForImage(imageName: String, folderName: String) -> URL? {
        guard let folderURL = getURLForFolder(folderName: folderName) else {
            return nil
        }
        return folderURL.appendingPathComponent(imageName + ".png")
    }
    // Get Images from the File Manager
}
