//
//  UIView+Frame.m
//  工具封装
//
//  Created by Bubble on 16/8/26.
//  Copyright © 2016年 Bubble. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView(Frame)



-(void)setX:(CGFloat)X{
    CGRect frame = self.frame;
    frame.origin.x = X;
    self.frame = frame;
}
-(CGFloat)X{
    return self.frame.origin.x;
}


-(void)setY:(CGFloat)Y{
    CGRect frame = self.frame;
    frame.origin.y = Y;
    self.frame = frame;
}
-(CGFloat)Y{
    return self.frame.origin.y;
}


-(CGFloat)Right{
    return self.frame.size.width + self.frame.origin.x;
}

-(CGFloat)Bottom{
    return self.frame.size.height + self.frame.origin.y;
}


-(CGFloat)W{
    return self.frame.size.width;
}
-(void)setW:(CGFloat)W{
    CGRect frame = self.frame;
    frame.size.width = W;
    self.frame = frame;
}

-(CGFloat)H{
    return self.frame.size.height;
}
-(void)setH:(CGFloat)H{
    CGRect frame = self.frame;
    frame.size.height = H;
    self.frame = frame;
}


-(CGSize)Size{
    return self.frame.size;
}
-(void)setSize:(CGSize)Size{
    CGRect frame = self.frame;
    frame.size = Size;
    self.frame = frame;
}


-(CGPoint)Origin{
    return self.frame.origin;
}
-(void)setOrigin:(CGPoint)Origin{
    CGRect frame = self.frame;
    frame.origin = Origin;
    self.frame = frame;
}









@end
