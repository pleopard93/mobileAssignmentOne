//
//  ViewController.swift
//  PhotoPicker
//
//  Created by Xinyi Ding on 9/6/16.
//  Copyright © 2016 Xinyi. All rights reserved.
//

import UIKit

class CameraViewController: UIViewController,
UIImagePickerControllerDelegate,
UINavigationControllerDelegate
{
    let sharedImageModel = ImageModle.sharedInstance
    var outputImage = CIImage()
    var context = CIContext()
    var brightnessFilter = CIFilter(name: "CIColorControls")
    
    @IBOutlet weak var photoImage: UIImageView!

    @IBAction func sliderValueChanged(sender: UISlider) {
        
        if photoImage.image != nil {
            brightnessFilter!.setValue(NSNumber(float: sender.value), forKey: "inputBrightness");
            outputImage = brightnessFilter!.outputImage!;
            let imageRef = context.createCGImage(outputImage, fromRect: outputImage.extent)
            let newUIImage = UIImage(CGImage: imageRef)
            photoImage.image = newUIImage;
        }
    }
    
    @IBAction func openCamera(sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera;
            imagePicker.allowsEditing = false
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func openPhotoLibrary(sender: UIButton) {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary;
            imagePicker.allowsEditing = true
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        photoImage.image = image
        let ciImage = CIImage(image: image)   //Important !
        brightnessFilter!.setValue(ciImage, forKey: kCIInputImageKey)
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    
    @IBAction func saveImage(sender: UIButton) {
        let imageData = UIImageJPEGRepresentation(photoImage.image!, 0.6)
        let compressedJPGImage = UIImage(data: imageData!)
        UIImageWriteToSavedPhotosAlbum(compressedJPGImage!, nil, nil, nil)
        
        sharedImageModel.saveImage("test", category: "cat1", image: compressedJPGImage!)
        
        let alertController = UIAlertController(title: "Success", message: "Your image has been saved to Photo Library!", preferredStyle: .Alert)
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action:UIAlertAction!) in
            print("you have pressed OK button");
        }
        alertController.addAction(OKAction)
        self.presentViewController(alertController, animated: true, completion:nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

