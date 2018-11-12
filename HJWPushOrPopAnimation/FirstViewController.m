//
//  FirstViewController.m
//  HJWPushOrPopAnimation
//
//  Created by yhjs on 2018/11/5.
//  Copyright © 2018 yhjs. All rights reserved.
//

#import "FirstViewController.h"
#import "HJWFloat/HJWFloatView.h"
#import "SecondViewController.h"


@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    self.navigationItem.title = @"first";
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [HJWFloatView showWithControllerName:@"SecondViewController"];
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
