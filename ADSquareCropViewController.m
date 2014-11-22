//
//  ADSquareCropViewController.m
//  SquareCropViewController
//
//  Created by Anna Dickinson on 11/22/14.
//  Copyright (c) 2014 Anna Dickinson. All rights reserved.
//

#import "ADSquareCropViewController.h"

@interface ADSquareCropViewController ()

@property (weak, nonatomic) IBOutlet UIView *cropOpeningView;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIView *referenceView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftBlockerScrollViewConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topBlockerScrollViewConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topSuperviewScrollViewConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftSuperviewScrollViewConstraint;


//@IBOutlet weak var scrollView: UIScrollView!
//@IBOutlet weak var imageView: UIImageView!
//@IBOutlet weak var referenceView: UIView!
//
//@IBOutlet weak var topBlockerScrollViewConstraint: NSLayoutConstraint!
//@IBOutlet weak var topSuperviewScrollViewConstraint: NSLayoutConstraint!
//
//@IBOutlet weak var leftBlockerScrollViewConstraint: NSLayoutConstraint!
//@IBOutlet weak var leftSuperviewScrollViewConstraint: NSLayoutConstraint!
//
//@IBOutlet weak var cropOpeningView: UIView!

@end

@implementation ADSquareCropViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
