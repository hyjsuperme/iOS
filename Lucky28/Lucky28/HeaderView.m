//
//  HeaderView.m
//  Lucky28
//
//  Created by 九旺网络 on 2016/10/26.
//  Copyright © 2016年 Jiuwang. All rights reserved.
//

#import "HeaderView.h"

@interface HeaderView ()
@property (nonatomic, strong) UIImageView *imageV;
@end

@implementation HeaderView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageV =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.20)];
        self.imageV.image =[UIImage imageNamed:@"HeaderView"];
        [self addSubview:self.imageV];
    }
    return self;
}
@end
