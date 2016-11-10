//
//  JWMyModelPopView.m
//  Lucky28
//
//  Created by 九旺网络 on 2016/11/10.
//  Copyright © 2016年 Jiuwang. All rights reserved.
//

#import "JWMyModelPopView.h"

@implementation JWMyModelPopView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        //背景遮盖
        UIView *backView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        backView.backgroundColor = [UIColor blackColor];
        backView.alpha = 0.7;
        [self addSubview:backView];
        //正真视图层
        UIView *ContentView = [[UIView alloc] initWithFrame:CGRectMake(20, 15, SCREEN_WIDTH - 40, SCREEN_HEIGHT -45)];
        ContentView.backgroundColor =[UIColor whiteColor];
        ContentView.layer.cornerRadius =5;
        ContentView.layer.masksToBounds =YES;
        [self addSubview:ContentView];
        UILabel *MyName =[[UILabel alloc]initWithFrame:CGRectMake(ContentView.width/2 -50,ContentView.height *0.0303, 100, 20)];
        MyName.text =@"我的模式";
        MyName.font =[UIFont systemFontOfSize:20];
        MyName.textAlignment =NSTextAlignmentCenter;
        MyName.textColor =[UIColor blackColor];
        [ContentView addSubview:MyName];
      
        UILabel *lin =[[UILabel alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT *0.0876, ContentView.width, 1)];
        lin.backgroundColor =JWColorA(200, 200, 200, 1);
        [ContentView addSubview:lin];
        //模式
        for (int i = 0; i < 8; i++) {
            int a = (i / 4);
            CGFloat BtnX = (i % 4)*80 + 10;
            CGFloat BtnY = a*48 +ContentView.height *0.1126;
            CGFloat BtnWidth = 70;
            CGFloat BtnHeight =40;
            
            
            UIButton *button =[[UIButton alloc]initWithFrame:CGRectMake(BtnX, BtnY, BtnWidth, BtnHeight)];
            button.tag =(i+1) * 10000;
            [button setTitle:[NSString stringWithFormat:@"模式%d",i+1] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"BetDefault"] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"ChooseBet"] forState:UIControlStateSelected];
            [ContentView addSubview:button];
        }
        
        UILabel *lin1 =[[UILabel alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT *0.26, ContentView.width, 1)];
        lin1.backgroundColor =JWColorA(200, 200, 200, 1);
        [ContentView addSubview:lin1];
        
        //投注按钮
        for (int i = 0; i < 28; i++) {
            int a = (i / 7);
            CGFloat BtnX = (i % 7)*44 + 20;
            CGFloat BtnY = a*44 +ContentView.height *0.32;
            CGFloat BtnWidth = 34;
            CGFloat BtnHeight =34;
            
            
            UIButton *button =[[UIButton alloc]initWithFrame:CGRectMake(BtnX, BtnY, BtnWidth, BtnHeight)];
            button.tag =(i+1) * 10000;
            [button setTitle:[NSString stringWithFormat:@"%d",i+1] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"placeholderNumber"] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"Number_back"] forState:UIControlStateSelected];
            [ContentView addSubview:button];
        }
        UILabel *lin2 =[[UILabel alloc]initWithFrame:CGRectMake(0, ContentView.height *0.6, ContentView.width, 1)];
        lin2.backgroundColor =JWColorA(200, 200, 200, 1);
        [ContentView addSubview:lin2];
        
        UILabel *showHand =[[UILabel alloc]initWithFrame:CGRectMake(0.048*ContentView.width, 0.62*ContentView.height, 70, 18)];
        showHand.text=@"投注梭哈";
        showHand.textColor =JWColorA(124, 124, 124, 1);
        [ContentView addSubview:showHand];
        //滑动器
        UISlider * slider =[[UISlider alloc]initWithFrame:CGRectMake(0.284 *ContentView.width, 0.625*ContentView.height, 164, 16)];
        [ContentView addSubview:slider];
        
        UILabel *showHandRight =[[UILabel alloc]initWithFrame:CGRectMake(0.824*ContentView.width, 0.62*ContentView.height, 70, 18)];
        showHandRight.text=@"(100)";
        showHandRight.textColor =JWColorA(124, 124, 124, 1);
        [ContentView addSubview:showHandRight];
        
        UIButton *AllShowHand =[[UIButton alloc]initWithFrame:CGRectMake(0.26*ContentView.width, 0.68*ContentView.height, 71, 43)];
        [AllShowHand setTitle:@"全额梭哈" forState:UIControlStateNormal];
        [AllShowHand setTitleColor:[UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1] forState:UIControlStateNormal];
        [AllShowHand setBackgroundImage:[UIImage imageNamed:@"CancelBtn"] forState:UIControlStateNormal];
        AllShowHand.titleLabel.font =[UIFont systemFontOfSize:16];
        [ContentView addSubview:AllShowHand];
        
        UIButton *AgainstChoose =[[UIButton alloc]initWithFrame:CGRectMake(0.485*ContentView.width, 0.68*ContentView.height, 71, 43)];
        [AgainstChoose setTitle:@"反选" forState:UIControlStateNormal];
        [AgainstChoose setTitleColor:[UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1] forState:UIControlStateNormal];
        [AgainstChoose setBackgroundImage:[UIImage imageNamed:@"CancelBtn"] forState:UIControlStateNormal];
         AgainstChoose.titleLabel.font =[UIFont systemFontOfSize:16];
        [ContentView addSubview:AgainstChoose];
        
        UIButton *Money =[[UIButton alloc]initWithFrame:CGRectMake(0.71*ContentView.width, 0.68*ContentView.height, 71, 43)];
        [Money setTitle:@"输入金额" forState:UIControlStateNormal];
        [Money setTitleColor:[UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1] forState:UIControlStateNormal];
        [Money setBackgroundImage:[UIImage imageNamed:@"BetDefault"] forState:UIControlStateNormal];
         Money.titleLabel.font =[UIFont systemFontOfSize:16];
        [ContentView addSubview:Money];
        
        UILabel *modelName =[[UILabel alloc]initWithFrame:CGRectMake(0.048*ContentView.width, 0.8*ContentView.height, 70, 18)];
        modelName.text=@"模式名称";
        modelName.textColor =JWColorA(124, 124, 124, 1);
        [ContentView addSubview:modelName];
        
        UIButton *ModelName1 =[[UIButton alloc]initWithFrame:CGRectMake(0.26*ContentView.width, 0.77*ContentView.height, 80, 40)];
        [ModelName1 setTitle:@"模式1" forState:UIControlStateNormal];
        [ModelName1 setTitleColor:[UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1] forState:UIControlStateNormal];
        [ModelName1 setBackgroundImage:[UIImage imageNamed:@"BetDefault"] forState:UIControlStateNormal];
        [ContentView addSubview:ModelName1];
        
        UIButton *delete =[[UIButton alloc]initWithFrame:CGRectMake(0.53*ContentView.width, 0.77*ContentView.height, 60, 40)];
        [delete setTitle:@"删除" forState:UIControlStateNormal];
        [delete setTitleColor:[UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1] forState:UIControlStateNormal];
        [delete setBackgroundImage:[UIImage imageNamed:@"CancelBtn"] forState:UIControlStateNormal];
        [ContentView addSubview:delete];
        
        UIButton *add =[[UIButton alloc]initWithFrame:CGRectMake(0.74*ContentView.width, 0.77*ContentView.height, 60, 40)];
        [add setTitle:@"新增" forState:UIControlStateNormal];
        [add setTitleColor:[UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1] forState:UIControlStateNormal];
        [add setBackgroundImage:[UIImage imageNamed:@"CancelBtn"] forState:UIControlStateNormal];
        [ContentView addSubview:add];
        
        
        UILabel *lin3 =[[UILabel alloc]initWithFrame:CGRectMake(0, ContentView.height *0.86, ContentView.width, 1)];
        lin3.backgroundColor =JWColorA(200, 200, 200, 1);
        [ContentView addSubview:lin3];
        
        UIButton *Yes =[[UIButton alloc]initWithFrame:CGRectMake(0.331*ContentView.width, 0.897*ContentView.height, 70, 40)];
        [Yes setTitle:@"确定" forState:UIControlStateNormal];
        [Yes setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [Yes setBackgroundImage:[UIImage imageNamed:@"YesBtn"] forState:UIControlStateNormal];
        [ContentView addSubview:Yes];
        
        UIButton *cancel =[[UIButton alloc]initWithFrame:CGRectMake(0.57*ContentView.width, 0.897*ContentView.height, 70, 40)];
        [cancel setTitle:@"取消" forState:UIControlStateNormal];
        [cancel setTitleColor:[UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1] forState:UIControlStateNormal];
        [cancel setBackgroundImage:[UIImage imageNamed:@"CancelBtn"] forState:UIControlStateNormal];
        [ContentView addSubview:cancel];
        
        
        
    }
    return self;
}


- (void)show{
    [self makeKeyAndVisible];
}
@end
