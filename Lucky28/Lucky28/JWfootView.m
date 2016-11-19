//
//  JWfootView.m
//  Lucky28
//
//  Created by 九旺网络 on 2016/10/31.
//  Copyright © 2016年 Jiuwang. All rights reserved.
//

#import "JWfootView.h"

@interface JWfootView ()

@end
@implementation JWfootView
- (UIButton *)autoBet{
    if (!_autoBet) {
        _autoBet =[[UIButton alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH/3, 55)];
        [_autoBet setBackgroundImage:[UIImage imageNamed:@"autoBetButton"] forState:UIControlStateNormal];
        [_autoBet setTitle:@"自动投注" forState:UIControlStateNormal];
        
    }
    return _autoBet;
}
- (UIButton *)clearBet{
    if (!_clearBet) {
        _clearBet =[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3,0,SCREEN_WIDTH/3, 55)];
        [_clearBet setBackgroundImage:[UIImage imageNamed:@"ClearBetButton"] forState:UIControlStateNormal];
        [_clearBet setImage:[UIImage imageNamed:@"ClearBetImage"] forState:UIControlStateNormal];
        [_clearBet setTitle:@"清除重选" forState:UIControlStateNormal];
        [_clearBet setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _clearBet.titleEdgeInsets =UIEdgeInsetsMake(0, 10, 0, 0);
    }
    return _clearBet;
}
- (UIButton *)YesBet{
    if (!_YesBet) {
        _YesBet =[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3*2,0,SCREEN_WIDTH/3, 55)];
        [_YesBet setBackgroundImage:[UIImage imageNamed:@"YesBetButton"] forState:UIControlStateNormal];
          [_YesBet setTitle:@"确认投注" forState:UIControlStateNormal];
    }
    return _YesBet;
}



-(instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        [self addSubview:self.autoBet];
        [self addSubview:self.clearBet];
        [self addSubview:self.YesBet];
    }
    return self;
}

@end
