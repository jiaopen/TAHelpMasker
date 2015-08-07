 //
//  ViewController.m
//  TAHelpMasker
//
//  Created by 李小盆 on 15/8/6.
//  Copyright (c) 2015年 Zip Lee. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+TAHelpMasker.h"

@interface ViewController ()

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
 
}

-(IBAction)actionShowHelpMasker:(id)sender
{
    [self displayMask];
}
@end
