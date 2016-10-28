//
//  InformView.m
//  Lucky28
//
//  Created by 九旺网络 on 2016/10/26.
//  Copyright © 2016年 Jiuwang. All rights reserved.
//

#import "InformView.h"

@implementation InformView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *image =[[UIImageView alloc]initWithFrame:CGRectMake(10, SCREEN_HEIGHT *0.06/2 -7, 14, 14)];
        image.image =[UIImage imageNamed:@"Inform"];
        [self addSubview:image];
    }
    return self;
}

@end
