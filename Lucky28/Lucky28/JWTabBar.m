//
//  JWTabBar.m
//  Lucky28
//
//  Created by hyj-pc on 16/10/24.
//  Copyright © 2016年 Jiuwang. All rights reserved.
//

#import "JWTabBar.h"

@implementation JWTabBar

/**
 *布局子控件
 */
- (void)layoutSubviews{
    [super layoutSubviews];
//    UIView *view =[[UIView alloc]initWithFrame:self.frame];
//    view.backgroundColor =JWTabBarBackgroundColor;
//    [[UITabBar appearance]insertSubview:view atIndex:0];
    //[self setBackgroundColor:JWTabBarBackgroundColor];
   // self.backgroundColor =JWTabBarBackgroundColor;
    CGFloat buttonW =self.frame.size.width/5;
    CGFloat buttonH =self.frame.size.height;
    CGFloat buttonY =0;
    //按钮的索引
    int buttonIndex =0;
    for (UIView *subView in self.subviews) {
        
        //过滤掉非TabBarButton
        if (subView.class != NSClassFromString(@"UITabBarButton")) continue ;
        
        //设置frame
        CGFloat buttonX =buttonIndex * buttonW;
        subView.frame =CGRectMake(buttonX, buttonY, buttonW, buttonH);
        //增加索引
        buttonIndex++;
    }
}

@end
