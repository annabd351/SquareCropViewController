//
//  DemoViewController.swift
//  SquareCropViewController
//
//  Created by Anna Dickinson on 10/15/14.
//  Copyright (c) 2014 Anna Dickinson. All rights reserved.
//

import UIKit

class DemoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pickImageButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        imageView.sizeToFit()
    }
    
    @IBAction func pickImageButtonPressed(sender: AnyObject) {
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

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destination = segue.destinationViewController as? ADSquareCropViewController {
            if let currentImage = imageView.image {
                destination.imageToCrop = currentImage
            }
            destination.cropCompletionHandler = {
                self.imageView.image = $0
            }
            destination.cancelCompletionHandler = {
                UIAlertView(title: "Crop cancelled", message: nil, delegate: nil, cancelButtonTitle: "Ok").show()
            }
        }
    }
}

