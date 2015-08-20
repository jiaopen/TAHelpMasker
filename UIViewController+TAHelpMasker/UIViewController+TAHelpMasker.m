//
//  UIViewController+TAHelpMasker.m
//  TAHelpMasker
//
//  Created by 李小盆 on 15/8/6.
//  Copyright (c) 2015年 Zip Lee. All rights reserved.
//

#import "UIViewController+TAHelpMasker.h"
#import <objc/runtime.h>

@interface TAHelpMasker : UIView

@end

@implementation TAHelpMasker

-(instancetype)init
{
    self = [super init];
    if (self) {
        
        self.alpha = 0.0;
        self.backgroundColor = [UIColor clearColor];
        self.frame = [UIScreen mainScreen].bounds;
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)]];
    }
    return self;
}

-(void) tap:(UIGestureRecognizer*) gesture
{
    [self dismiss];
}


+(void)showWithImageName:(NSString*) imageName
{
    TAHelpMasker* helpMakser = [[self alloc] init];
    ;
    UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    [helpMakser addSubview:imageView];
   
    if ([UIScreen mainScreen].bounds.size.height == 480.f)
    {
        imageView.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, imageView.image.size.height*[UIScreen mainScreen].bounds.size.width/imageView.image.size.width);
    }else
    {
        imageView.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
    }
    helpMakser.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
    [helpMakser show];
}

+(void) dismiss
{
    NSEnumerator *frontToBackWindows = [UIApplication.sharedApplication.windows reverseObjectEnumerator];
    UIScreen *mainScreen = UIScreen.mainScreen;
    
    for (UIWindow *window in frontToBackWindows)
        if (window.screen == mainScreen && window.windowLevel == UIWindowLevelNormal) {
            [window.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                if([obj isKindOfClass:[TAHelpMasker class]])
                {
                    [obj performSelector:@selector(dismiss)];
                }
            }];
        }
}

-(void)show{
    NSEnumerator *frontToBackWindows = [UIApplication.sharedApplication.windows reverseObjectEnumerator];
    UIScreen *mainScreen = UIScreen.mainScreen;
    
    for (UIWindow *window in frontToBackWindows)
        if (window.screen == mainScreen && window.windowLevel == UIWindowLevelNormal) {
            [window addSubview:self];
            break;
        }
    
    [UIView animateWithDuration:0.3  animations:^{
        self.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}

-(void) dismiss
{
    [UIView animateWithDuration:0.3  animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end

@implementation UIViewController (TAHelpMasker)


+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originalSelector = @selector(viewDidAppear:);
        SEL swizzledSelector = @selector(ta_viewDidAppear:);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (success) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

- (void)ta_viewDidAppear:(BOOL)animated
{
    [self ta_viewDidAppear:animated];
    if (self.displayMaskWhenViewDidAppear) {
        [self displayMask];
    }
}

-(void)displayMask
{
    if (self.maskDictionary) {
        CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
        __block NSString* imageName;
        if (screenHeight == 480.f) {
            imageName = [self.maskDictionary objectForKey:@"3.5"];
        }else if (screenHeight == 568.f) {
            imageName = [self.maskDictionary objectForKey:@"4.0"];
        }else if (screenHeight == 667.f) {
            imageName = [self.maskDictionary objectForKey:@"4.7"];
        }else if (screenHeight == 736.f) {
            imageName = [self.maskDictionary objectForKey:@"5.5"];
        }
        
        if (!imageName) {
            [self.maskDictionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                NSString* keyString = key;
                //Use 2x image as default mask image.
                if (![keyString isEqualToString:@"3.5"] && ![keyString isEqualToString:@"5.5"]) {
                    imageName = obj;
                }
            }];
        }
        [TAHelpMasker showWithImageName:imageName];
    }else if(self.maskImageName)
    {
        [TAHelpMasker showWithImageName:self.maskImageName];
    }
}

- (BOOL)displayMaskWhenViewDidAppear
{
    NSNumber *number = objc_getAssociatedObject(self, _cmd);
    if (number) {
        return number.boolValue;
    }
    self.displayMaskWhenViewDidAppear = YES;
    return YES;
}

- (void)setDisplayMaskWhenViewDidAppear:(BOOL)displayMaskWhenViewDidAppear
{
    objc_setAssociatedObject(self, @selector(displayMaskWhenViewDidAppear), @(displayMaskWhenViewDidAppear), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString*)maskImageName
{
    NSString *imageName = objc_getAssociatedObject(self, _cmd);
    return imageName;
}

- (void)setMaskImageName:(NSString *)maskImageName
{
    if (self.maskDictionary) {
        objc_setAssociatedObject(self, @selector(maskImageName), nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return;
    }
    objc_setAssociatedObject(self, @selector(maskImageName), maskImageName, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSDictionary*)maskDictionary
{
    NSDictionary *dic = objc_getAssociatedObject(self, _cmd);
    
    return dic;
}

- (void)setMaskDictionary:(NSDictionary *)maskDictionary
{
    if (maskDictionary) {
        self.maskImageName = nil;
    }
    objc_setAssociatedObject(self, @selector(maskDictionary), maskDictionary, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
