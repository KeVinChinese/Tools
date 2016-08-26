//
//  UIColor+Toolkit.h
//  hwb
//
//  Created by Bubble on 15/7/16.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Tools)

+(UIColor *) colorWithHexString:(NSString *) hexColor;
+(UIColor *) colorWithHex:(NSInteger) hexColor;

+(UIColor *) colorWithHexString:(NSString *) hexColor withAlpha:(CGFloat) alpha;
+(UIColor *) colorWithHex:(NSInteger) hexColor withAlpha:(CGFloat) alpha;

@end
