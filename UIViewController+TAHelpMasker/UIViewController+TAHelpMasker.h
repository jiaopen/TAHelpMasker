//
//  UIViewController+TAHelpMasker.h
//  TAHelpMasker
//
//  Created by 李小盆 on 15/8/6.
//  Copyright (c) 2015年 Zip Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (TAHelpMasker)

//Default YES. If set to NO, should call displayMask to display the mask.
@property (nonatomic, assign) BOOL displayMaskWhenViewDidAppear;

//Set mask image after init, if maskDictionary is not nil, this property not worked.
@property (nonatomic, strong) NSString* maskImageName;

//Set mask images after init, e.g:@[@"3.5":@"help_mask_for_3_inch_5.png"]
@property (nonatomic, strong) NSDictionary* maskDictionary;


-(void) displayMask;
@end
