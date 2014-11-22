//
//  ProgrammaticViewController.swift
//  SquareCropViewController
//
//  Created by Anna Dickinson on 11/22/14.
//  Copyright (c) 2014 Anna Dickinson. All rights reserved.
//

import UIKit

class ProgrammaticViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil);
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }

    @IBAction func pickImagePresed(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) {
            imagePicker.sourceType = .PhotoLibrary
            imagePicker.delegate = self
            imagePicker.allowsEditing = false
            imagePicker.modalPresentationStyle = UIModalPresentationStyle.OverFullScreen
            presentViewController(imagePicker, animated: true, completion: nil)
        }

    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = pickedImage
        }
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func cropImagePressed(sender: AnyObject) {
        let cropViewController = ADSquareCropViewController(nibName: "ADSquareCropViewController", bundle: nil);
        cropViewController.cropCompletionHandler = {
            self.imageView.image = $0
            self.dismissViewControllerAnimated(true, completion: nil);
        }
        cropViewController.cancelCompletionHandler = {
            UIAlertView(title: "Crop cancelled", message: nil, delegate: nil, cancelButtonTitle: "Ok").show()
            self.dismissViewControllerAnimated(true, completion: nil);
        }
        cropViewController.imageToCrop = imageView.image;

        self.presentViewController(cropViewController, animated: true, completion: nil);
    }
}
