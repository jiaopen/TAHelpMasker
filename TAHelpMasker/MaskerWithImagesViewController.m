//
//  MaskerWithImagesViewController.m
//  TAHelpMasker
//
//  Created by 李小盆 on 15/8/7.
//  Copyright (c) 2015年 Zip Lee. All rights reserved.
//

#import "MaskerWithImagesViewController.h"
#import "UIViewController+TAHelpMasker.h"

@implementation MaskerWithImagesViewController


-(void)awakeFromNib
{
    self.maskDictionary = @{@"4.0": @"user_home_guideview@2x.png",
                            @"4.7": @"user_home_guideview750.png",
                            @"5.5": @"user_home_guideview@3x.png",};
}

@end
