//
//  CGSize+Extensions.swift
//  SquareCropViewController
//
//  Created by Anna Dickinson on 10/15/14.
//  Copyright (c) 2014 Anna Dickinson. All rights reserved.
//

import UIKit

extension CGSize {
    func maxDimension() -> CGFloat { return max(width, height) }
    func minDimension() -> CGFloat { return min(width, height) }
    func aspect() -> CGFloat { return width/height }
}
