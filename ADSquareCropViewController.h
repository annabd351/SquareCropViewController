//
//  ADSquareCropViewController.h
//  SquareCropViewController
//
//  Created by Anna Dickinson on 11/22/14.
//  Copyright (c) 2014 Anna Dickinson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADSquareCropViewController : UIViewController

@property UIImage* imageToCrop;

// typealias CropCompletionHandlerType = (UIImage?) -> ()
// typealias CancelCompletionHandlerType = () -> ()

// @property (nonatomic, copy) returnType (^blockName)(parameterTypes);

@property (nonatomic, copy) void (^cropCompletionHandler)(UIImage *);
@property (nonatomic, copy) void (^cancelCompletionHandler)();


@end
