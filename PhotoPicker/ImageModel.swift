//
//  ImageModel.swift
//  PhotoPicker
//
//  Created by Xinyi Ding on 9/6/16.
//  Copyright © 2016 Xinyi. All rights reserved.
//

import Foundation
import UIKit

class ImageModle {
    
    static let sharedInstance = ImageModle()
    
    var imageNames = ["test1", "test2"]
    var imageCategories = ["cat1", "cat2"]
    
    
    func getImageNames() -> Array<String> {
        
        return imageNames
    }
    
    func saveImage(name: String, category: String, image: UIImage) {
        self.imageNames.append(name)
        self.imageCategories.append(category)
        
        let fileManager = NSFileManager.defaultManager()
        let paths = (NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString).stringByAppendingPathComponent(name)
        print(paths)
        let imageData = UIImageJPEGRepresentation(image, 0.5)
        fileManager.createFileAtPath(paths as String, contents: imageData, attributes: nil)
    }
    
    func getDirectoryPath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    func getImageByIndex(index: Int) -> UIImage {
        
       // let fileManager = NSFileManager.defaultManager()
        let imagePAth = (self.getDirectoryPath() as NSString).stringByAppendingPathComponent(self.imageNames[index])
//        if fileManager.fileExistsAtPath(imagePAth){
//            let image = UIImage(contentsOfFile: imagePAth)
//        }else{
//            print("No Image")
//        }
        let image = UIImage(contentsOfFile: imagePAth)
        return image!
    }

    
}