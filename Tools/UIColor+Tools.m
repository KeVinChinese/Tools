//
//  UIColor+Toolkit.m
//  hwb
//
//  Created by Bubble on 15/7/16.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import "UIColor+Tools.h"

@implementation UIColor (Tools)

+(UIColor *) colorWithHexString:(NSString *) hexColor{
    return [UIColor colorWithHexString:hexColor withAlpha:1];
}

+(UIColor *) colorWithHex:(NSInteger) hexColor{
    NSString *hexString = [NSString stringWithFormat:@"%ld",hexColor];
    return [UIColor colorWithHexString:hexString];
}

+(UIColor *) colorWithHexString:(NSString *) hexColor withAlpha:(CGFloat)alpha{
    unsigned int red,green,blue;
    NSRange range;
    range.length = 2;
    range.location = 0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&red];
    range.location = 2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&green];
    range.location = 4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&blue];
    return [UIColor colorWithRed:(float)(red/255.0f)green:(float)(green / 255.0f) blue:(float)(blue / 255.0f)alpha:alpha];
}

+(UIColor *) colorWithHex:(NSInteger) hexColor withAlpha:(CGFloat)alpha{
    NSString *hexString = [NSString stringWithFormat:@"%ld",hexColor];
    return [UIColor colorWithHexString:hexString withAlpha:alpha];

}

@end
