//
//  UIImage+Extensions.swift
//  SquareCropViewController
//
//  Created by Anna Dickinson on 10/15/14.
//  Copyright (c) 2014 Anna Dickinson. All rights reserved.
//

import UIKit

extension UIImage {
    func minDimension() -> CGFloat { return size.minDimension() }
    func maxDimension() -> CGFloat { return size.maxDimension() }
    func dimensionalDifference() -> CGFloat { return maxDimension() - minDimension() }
    func aspect() -> CGFloat { return size.aspect() }
    
    func croppedToRect(cropRect: CGRect) -> UIImage {
        UIGraphicsBeginImageContext(cropRect.size)
        
        var context = UIGraphicsGetCurrentContext()
        CGContextScaleCTM(context, 1.0, 1.0);
        CGContextTranslateCTM(context, -cropRect.origin.x, -cropRect.origin.y)
        
        self.drawAtPoint(CGPointZero)
        
        let result =  UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }
    
    func scaledBy(scalar: CGFloat) -> UIImage {
        let newRect = CGRect(origin: CGPointZero, size: self.size).scaledBy(scalar)
        
        UIGraphicsBeginImageContext(newRect.size)
        
        self.drawInRect(newRect)
        
        let result =  UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }
}
