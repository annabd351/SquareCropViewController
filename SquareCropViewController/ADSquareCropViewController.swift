//
//  ADSquareCropViewController.swift
//  SquareCropViewController
//
//  Created by Anna Dickinson on 10/25/14.
//  Copyright (c) 2014 Anna Dickinson. All rights reserved.
//

import UIKit

class ADSquareCropViewController: UIViewController, UIScrollViewDelegate {

    // The image we want to crop
    var imageToCrop: UIImage? {
        didSet {
            if imageView != nil {
                imageView.image = imageToCrop!
                imageView.setNeedsUpdateConstraints()
            }
        }
    }

    // Called when the crop button is pressed (after dismissing the view controller).
    // The UIImage parameter contains cropped image.
    typealias CropCompletionHandlerType = (UIImage?) -> ()
    var cropCompletionHandler: CropCompletionHandlerType?

    // Called when the cancel button is pressed (after dismissing the view controller).
    typealias CancelCompletionHandlerType = () -> ()
    var cancelCompletionHandler: CancelCompletionHandlerType?

    // These should be defined by the SDK, but they're missing for Swift (it's a bug)
    enum ADLayoutPriority: UILayoutPriority {
        case Required  = 1000
        case DefaultHigh  = 750
        case DefaultLow  = 250
        case FittingSizeLevel  = 50
    }

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var referenceView: UIView!

    @IBOutlet weak var topBlockerScrollViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var topSuperviewScrollViewConstraint: NSLayoutConstraint!

    @IBOutlet weak var leftBlockerScrollViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var leftSuperviewScrollViewConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var cropOpeningView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        assert({ self.imageToCrop != nil }(), "imageToCrop must be set before ADSquareCropViewController's view is loaded.")
        
        imageView.image = imageToCrop!
    }

    
    // updateViewConstraints is where we can programmaticly modify constraints based on things
    // which aren't known at compile time.  In this case, a few things depend on the aspect ratio
    // of the image, which could be anything.  
    
    override func updateViewConstraints() {
        
        // Our constraints depend on the aspect ratio of the imageView.
        // This method causes imageView to resize itself to fit the image it contains.
        imageView.sizeToFit()
        
        // Configure the scrollView to scroll in one dimension (the larger imageView dimension), but
        // not the other.  
        
        // For a UIScrollView to work correctly, it needs to be constrained to its superview (self.view).
        // (see https://developer.apple.com/library/ios/technotes/tn2154/_index.html "UIScrollView And Autolayout")
        
        // To disable scrolling in a particular dimension, we can disable the constraint to the superview.
        // We do this by lowering the priority of the scrollView-superview constraint relative to the
        // scrollView-blocker constraint: the lower priority constraint is disregarded by autolayout
        // and effectively disabled.

        if imageView.bounds.size.aspect() >= 1 {
            // Landscape image
            
            // Allow horizontal scrolling by enabling the superview constraint
            leftSuperviewScrollViewConstraint.priority = ADLayoutPriority.DefaultHigh.rawValue
            
            // Prohibit vertical scrolling by disabling the superview constraint
            topSuperviewScrollViewConstraint.priority = ADLayoutPriority.DefaultLow.rawValue
        }
        else {
            // Portrait image

            // ...and vice-versa
            leftSuperviewScrollViewConstraint.priority = ADLayoutPriority.DefaultLow.rawValue
            topSuperviewScrollViewConstraint.priority = ADLayoutPriority.DefaultHigh.rawValue
        }

        // When the image and device orientations are mis-matched (e.g. device in portrait, image
        // in landscape), the smallest dimension of the image is oriented along the largest dimension
        // of the device.  For visual balance, we want the scrollView to be centered in the display
        // along the largest dimenision.
        
        // Since the blockers are constrained between the superview and the crop square, they're
        // already in the correct position to fill the empty space along the superview's largest dimension. 
        // So, we can center the scrollView simply by constraining it to the blockers.
        
        if imageView.bounds.size.aspect() >= 1 {
            
            // Use the top blocker to push the scrollView down
            topBlockerScrollViewConstraint.priority = ADLayoutPriority.DefaultHigh.rawValue
            
            // We also need to disable the left blocker constraint so it doesn't conflict
            // with the superview constraint we used to enable horizontal scrolling.
            leftBlockerScrollViewConstraint.priority = ADLayoutPriority.DefaultLow.rawValue
        }
        else {
            topBlockerScrollViewConstraint.priority = ADLayoutPriority.DefaultLow.rawValue
            leftBlockerScrollViewConstraint.priority = ADLayoutPriority.DefaultHigh.rawValue
        }

        super.updateViewConstraints()
    }
    
    // To configure the scrollView, we need to know it's actual bounds and the size of the
    // crop opening.  Since these views are controlled by autolayout, viewDidLayoutSubviews
    // is the place to handle this -- we know autolayout has completed.

    // We also need to know the superview bounds;  however, the superview hasn't appeared yet,
    // so it's bounds may not be correct.  To deal with this, we create a dummy (hidden) reference
    // view constrained to the full size of the super view.  Since we know all subviews have been
    // laid out by now, we can rely on the dimensions of the reference view to be correct.
    
    override func viewDidLayoutSubviews() {
        
        let cropDimension = cropOpeningView.bounds.size.minDimension()

        // Zoom the scrollView so it shows the entire imageView in its smallest dimension.
        scrollView.maximumZoomScale = cropDimension/imageView.bounds.size.minDimension()
        scrollView.minimumZoomScale = scrollView.maximumZoomScale
        
        scrollView.zoomScale = scrollView.minimumZoomScale

        let horizontalInset = (referenceView.bounds.width - cropDimension)/2 - scrollView.frame.origin.x
        let verticalInset = (referenceView.bounds.height - cropDimension)/2 - scrollView.frame.origin.y
        
        scrollView.contentInset = UIEdgeInsets(
            top: verticalInset,
            left: horizontalInset,
            bottom: verticalInset,
            right: horizontalInset)
        
        // Since we changed some scrollView properties, we need to let autolayout do another
        // pass (if necessary).
        self.view.layoutIfNeeded()
        
        super.viewDidLayoutSubviews()
    }
    
    @IBAction func cropButtonPressed(sender: AnyObject) {
        let cropDimension = cropOpeningView.bounds.size.minDimension()
        let contentRectVisibleInScrollView = CGRect(
            origin: CGPoint(x: scrollView.contentOffset.x + scrollView.contentInset.left,
                y: scrollView.contentOffset.y + scrollView.contentInset.top),
            size: CGSize(width: cropDimension, height: cropDimension))
        
        let imageViewRect = contentRectVisibleInScrollView.scaledBy(1/scrollView.zoomScale)
        
        self.dismissViewControllerAnimated(true, completion: {
            if self.cropCompletionHandler != nil {
                self.cropCompletionHandler!(self.imageView.image?.croppedToRect(imageViewRect))
            }
        })

    }
  
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: cancelCompletionHandler)
    }

    @IBAction func rotateButtonPressed(sender: AnyObject) {
        
        if let currentImage = imageView.image {
            var newOrientation: UIImageOrientation
            
            switch (currentImage.imageOrientation) {
            case .Up: newOrientation = .Right; break
            case .Right: newOrientation = .Down; break
            case .Down: newOrientation = .Left; break
            case .Left: newOrientation = .Up; break
            default: newOrientation = .Up; break
            }
            
            imageView.image = UIImage(CGImage: currentImage.CGImage, scale: 1.0, orientation: newOrientation)
            
            // Since our constraints are, in part, based on the imageView's aspect ratio, we need to make
            // sure they are updated.
            self.view.setNeedsUpdateConstraints()
        }
    }

    
    // UIScrollView delegate method
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
