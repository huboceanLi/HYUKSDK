//
//  PopViewController.m
//  MYSaSClerk
//
//  Created by chong on 2019/11/30.
//  Copyright © 2019 chong. All rights reserved.
//

#import "PopViewController.h"

@interface PopViewController ()

@end

@implementation PopViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initData];
        [self initSubViews];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

- (void)initData
{}

- (void)initSubViews
{
    self.animationStyle = QMUIModalPresentationAnimationStyleSlide;
    
    self.dimmingView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.55f];
    
}

- (void)loadContent
{}



@end
