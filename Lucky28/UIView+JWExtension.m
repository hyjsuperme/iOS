//
//  UIView+JWExtension.m
//  Lucky28
//
//  Created by hyj-pc on 16/10/24.
//  Copyright © 2016年 Jiuwang. All rights reserved.
//

#import "UIView+JWExtension.h"

@implementation UIView (JWExtension)

- (CGFloat)width{
    return  self.frame.size.width;
}
- (void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}


- (CGFloat)height{
    return self.frame.size.height;
}
- (void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame =frame;
}


- (CGFloat)X{
    return self.frame.origin.x;
}
- (void)setX:(CGFloat)X{
    CGRect frame = self.frame;
    frame.origin.x =X;
    self.frame =frame;
}


- (CGFloat)Y{
    return  self.frame.origin.y;
}
- (void)setY:(CGFloat)Y{
    CGRect frame =self.frame;
    frame.origin.y =Y;
    self.frame =frame;
}

- (CGFloat)centerX{
    return self.center.x;
}
- (void)setCenterX:(CGFloat)centerX{
    CGPoint center =self.center;
    center.x =centerX;
    self.center =center;
}

- (CGFloat)centerY{
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY{
    CGPoint center =self.center;
    center.y =centerY;
    self.center =center;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}


@end
