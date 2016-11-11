//
//  JWMyModelPopView.m
//  Lucky28
//
//  Created by 九旺网络 on 2016/11/10.
//  Copyright © 2016年 Jiuwang. All rights reserved.
//

#import "JWMyModelPopView.h"

@interface JWMyModelPopView ()
/**选中模式*/
@property (nonatomic, strong) UIButton *ModelSelect;
@property (nonatomic, strong) UILabel *showHandRight;

@end
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
        //编辑
        UIButton *rightEditing =[[UIButton alloc]initWithFrame:CGRectMake(ContentView.width -60, ContentView.height *0.029, 50, 30)];
        [rightEditing setTitle:@"编辑" forState:UIControlStateNormal];
        rightEditing.backgroundColor =[UIColor redColor];
          [rightEditing setBackgroundImage:[UIImage imageNamed:@"DoneButton"] forState:UIControlStateNormal];
        [rightEditing setBackgroundImage:[UIImage imageNamed:@"BetLoading"] forState:UIControlStateSelected];
        [ContentView addSubview:rightEditing];
        [rightEditing addTarget:self action:@selector(editingClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        //模式
        for (int i = 0; i < 8; i++) {
            int a = (i / 4);
            CGFloat BtnX = (i % 4)*80 + 10;
            CGFloat BtnY = a*48 +ContentView.height *0.1126;
            CGFloat BtnWidth = 70;
            CGFloat BtnHeight =40;
            
            
            UIButton *button =[[UIButton alloc]initWithFrame:CGRectMake(BtnX, BtnY, BtnWidth, BtnHeight)];
            button.tag =(i+1) * 100001;
            [button setTitle:@"+" forState:UIControlStateNormal];
            button.titleLabel.font =[UIFont systemFontOfSize:24 ];
            [button setTitleColor:[UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1] forState:UIControlStateNormal];
            
            [button setBackgroundImage:[UIImage imageNamed:@"BetDefault"] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"ChooseBet"] forState:UIControlStateSelected];
            [ContentView addSubview:button];
            //[button addTarget:self action:@selector(modelClick:) forControlEvents:UIControlEventTouchUpInside];
            button.userInteractionEnabled =NO;
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
            button.userInteractionEnabled =NO;
          
            [ContentView addSubview:button];
        }
        UILabel *lin2 =[[UILabel alloc]initWithFrame:CGRectMake(0, ContentView.height *0.6, ContentView.width, 1)];
        lin2.backgroundColor =JWColorA(200, 200, 200, 1);
        [ContentView addSubview:lin2];
        
        UILabel *showHand =[[UILabel alloc]initWithFrame:CGRectMake(0.048*ContentView.width, 0.62*ContentView.height, 70, 18)];
        showHand.text=@"投注梭哈";
        showHand.textColor =JWColorA(124, 124, 124, 1);
        [ContentView addSubview:showHand];
       
        UIImage *setLeft =[UIImage imageNamed:@"chooseSlider"];
        UIImage *setRigth =[UIImage imageNamed:@"sliderLine"];
        //滑动块图片
        UIImage *thumbImage =[UIImage imageNamed:@"sliderBall"];
        //滑动器
        UISlider * slider =[[UISlider alloc]initWithFrame:CGRectMake(0.284 *ContentView.width, 0.625*ContentView.height, 164, 16)];
        slider.backgroundColor =[UIColor clearColor];
        slider.value =0.5;
        slider.minimumValue =0.0;
        slider.maximumValue =1.0;
        [slider setMinimumTrackImage:setLeft forState:UIControlStateNormal];
        [slider setMaximumTrackImage:setRigth forState:UIControlStateNormal];
        //这里要加UIControlStateHighlighted的状态，不然在滑动的时候会变回原生的状态
        [slider setThumbImage:thumbImage forState:UIControlStateHighlighted];
        [slider setThumbImage:thumbImage forState:UIControlStateNormal];
        [ContentView addSubview:slider];
        //滑块拖动时的事件
        [slider addTarget:self action:@selector(sliderValue:) forControlEvents:UIControlEventValueChanged];
        
        
        
        self.showHandRight =[[UILabel alloc]initWithFrame:CGRectMake(0.824*ContentView.width, 0.62*ContentView.height, 70, 18)];
        self.showHandRight.text=@"(100)";
        self.showHandRight.textColor =JWColorA(124, 124, 124, 1);
        [ContentView addSubview:self.showHandRight];
        
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
        
        UILabel *modelName =[[UILabel alloc]initWithFrame:CGRectMake(0.048*ContentView.width, 0.78*ContentView.height, 70, 18)];
        modelName.text=@"模式名称";
        modelName.textColor =JWColorA(124, 124, 124, 1);
        [ContentView addSubview:modelName];
        
        UIButton *ModelName1 =[[UIButton alloc]initWithFrame:CGRectMake(0.26*ContentView.width, 0.77*ContentView.height, 160, 40)];
        [ModelName1 setTitle:@"模式1" forState:UIControlStateNormal];
        [ModelName1 setTitleColor:[UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1] forState:UIControlStateNormal];
        [ModelName1 setBackgroundImage:[UIImage imageNamed:@"BetDefault"] forState:UIControlStateNormal];
        [ContentView addSubview:ModelName1];
        
        UIButton *delete =[[UIButton alloc]initWithFrame:CGRectMake(0.74*ContentView.width, 0.77*ContentView.height, 60, 40)];
        [delete setTitle:@"删除" forState:UIControlStateNormal];
        [delete setTitleColor:[UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1] forState:UIControlStateNormal];
        [delete setBackgroundImage:[UIImage imageNamed:@"CancelBtn"] forState:UIControlStateNormal];
        [ContentView addSubview:delete];
        
//        UIButton *add =[[UIButton alloc]initWithFrame:CGRectMake(0.74*ContentView.width, 0.77*ContentView.height, 60, 40)];
//        [add setTitle:@"编辑" forState:UIControlStateNormal];
//        [add setTitleColor:[UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1] forState:UIControlStateNormal];
//        [add setBackgroundImage:[UIImage imageNamed:@"CancelBtn"] forState:UIControlStateNormal];
//        [ContentView addSubview:add];
        
        
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
        
        [cancel addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [Yes  addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return self;
}
//编辑模式
- (void)editingClick:(UIButton *)Edit{
    Edit.selected =!Edit.selected;
    if (Edit.selected) {
        for (int i =0; i<8; i++) {
            UIButton *button =[self viewWithTag:(i+1) * 100001];
            button.userInteractionEnabled =YES;
            [button addTarget:self action:@selector(modelClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        for (int i =0; i<28; i++) {
            UIButton *button =[self viewWithTag:(i+1) * 10000];
            button.userInteractionEnabled =YES;
            [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        }
    } else{
        //关闭编辑模式
        for (int i =0; i<8; i++) {
            UIButton *button =[self viewWithTag:(i+1) * 100001];
            button.userInteractionEnabled =NO;
            [button addTarget:self action:@selector(modelClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        for (int i =0; i<28; i++) {
            UIButton *button =[self viewWithTag:(i+1) * 10000];
            button.userInteractionEnabled =NO;
            [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        
    }
    
}

- (void)sliderValue:(UISlider *)slider{
    self.showHandRight.text =[NSString stringWithFormat:@"(%.2f)",slider.value];
    NSLog(@"%f",slider.value);
}
//模式点击
- (void)modelClick:(UIButton *)sender{
    sender.selected =YES;
    if ([sender.currentTitle isEqualToString:@"+"]) {
        [sender setTitle:@"添加" forState:UIControlStateNormal];
        [self.ModelSelect setTitle:@"+" forState:UIControlStateNormal];
      
        for (int i =0; i<28; i++) {
            UIButton *button =[self viewWithTag:(i+1) * 10000];
            button.userInteractionEnabled =YES;
            [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        }
    
    }
    if (self.ModelSelect == sender) {
        return;
    }
   
    self.ModelSelect.selected =NO;
    self.ModelSelect =sender;

}
//选中下注类型
- (void)btnClick:(UIButton *)sender{
    sender.selected =!sender.selected;
    if (sender.selected) {
        [sender setBackgroundImage:[UIImage imageNamed:@"Number_back"] forState:UIControlStateSelected];
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    } else{
        [sender setTitleColor:[UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1]  forState:UIControlStateNormal];
    }
}
- (void)click:(UIButton *)sender{
    if ([sender.currentTitle isEqualToString:@"确定"]) {
        
    }
    self.hidden =YES;
}
- (void)show{
    [self makeKeyAndVisible];
}
@end
