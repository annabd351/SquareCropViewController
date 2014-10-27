//
//  CGRect+Extensions.swift
//  SquareCropViewController
//
//  Created by Anna Dickinson on 10/15/14.
//  Copyright (c) 2014 Anna Dickinson. All rights reserved.
//

import UIKit

extension CGRect {
    func scaledBy(scalar: CGFloat) -> CGRect {
        let newOrigin = CGPoint(x: origin.x * scalar, y: origin.y * scalar)
        let newSize = CGSize(width: width * scalar, height: height * scalar)
        return CGRect(origin: newOrigin, size: newSize)
    }
    
    func scaledBy(size: CGSize) -> CGRect {
        let newOrigin = CGPoint(x: origin.x * size.width, y: origin.y * size.height)
        let newSize = CGSize(width: width * size.width, height: height * size.height)
        return CGRect(origin: newOrigin, size: newSize)
    }
}