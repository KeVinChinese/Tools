//
//  UIImage+Tools.m
//  工具封装
//
//  Created by Bubble on 16/8/23.
//  Copyright © 2016年 Bubble. All rights reserved.
//

#import "UIImage+Tools.h"

@implementation UIImage(Tools)

/**
 *  设置不伸展的图片
 */
-(UIImage *) imageForNotOutstretched{
    
    // 设置端盖的值
    CGFloat top = self.size.height * 0.5;
    CGFloat left = self.size.width * 0.5;
    CGFloat bottom = self.size.height * 0.5;
    CGFloat right = self.size.width * 0.5;
    
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(top, left, bottom, right);
    
    // 拉伸图片
    return [self resizableImageWithCapInsets:edgeInsets];
    
}




@end
