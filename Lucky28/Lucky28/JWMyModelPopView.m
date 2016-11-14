//
//  JWMyModelPopView.m
//  Lucky28
//
//  Created by 九旺网络 on 2016/11/10.
//  Copyright © 2016年 Jiuwang. All rights reserved.
//

#import "JWMyModelPopView.h"

@interface JWMyModelPopView ()<UITextFieldDelegate>
/**选中模式*/
@property (nonatomic, strong) UIButton *ModelSelect;
/**压注金额*/
@property (nonatomic, strong) UILabel *showHandRight;
/**自定义模式选择号码*/
@property (nonatomic, strong) NSMutableArray *BetArray;
/**模式名称*/
@property (nonatomic, strong) UITextField *ModelName1;
/**滚动条*/
@property (nonatomic, strong) UISlider *slider;
/**梭哈*/
@property (nonatomic, strong) UIButton *AllShowHand;
/**反选*/
@property (nonatomic, strong) UIButton *AgainstChoose;
/**自定义模式条数*/
@property (nonatomic, strong) NSMutableArray *customModel;
/**每条模型数据*/
@property (nonatomic, strong) NSMutableDictionary *Model;
@end
@implementation JWMyModelPopView

- (NSMutableArray *)customModel{
    if (!_customModel) {
        _customModel =[NSMutableArray array];
    }
    return _customModel;
}

- (NSMutableArray *)BetArray{
    if (!_BetArray) {
        _BetArray =[NSMutableArray array];
    }
    return _BetArray;
}
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
            CGFloat BtnY = a*44 +ContentView.height *0.30;
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
        UILabel *lin2 =[[UILabel alloc]initWithFrame:CGRectMake(0, ContentView.height *0.58, ContentView.width, 1)];
        lin2.backgroundColor =JWColorA(200, 200, 200, 1);
        [ContentView addSubview:lin2];
        
        
        
        
        UILabel *modelName =[[UILabel alloc]initWithFrame:CGRectMake(0.048*ContentView.width, 0.608*ContentView.height, 70, 18)];
        modelName.text=@"模式名称";
        modelName.textColor =JWColorA(124, 124, 124, 1);
        [ContentView addSubview:modelName];
        
        self.ModelName1 =[[UITextField alloc]initWithFrame:CGRectMake(0.26*ContentView.width, 0.59*ContentView.height, 160, 40)];
        self.ModelName1.placeholder =@"请输入模式名称";
        self.ModelName1.borderStyle =UITextBorderStyleRoundedRect;
        self.ModelName1.userInteractionEnabled =NO;
        self.ModelName1.delegate =self;
        
        [ContentView addSubview:self.ModelName1];
        
        UIButton *delete =[[UIButton alloc]initWithFrame:CGRectMake(0.74*ContentView.width, 0.59*ContentView.height, 60, 40)];
        [delete setTitle:@"删除" forState:UIControlStateNormal];
        [delete setTitleColor:[UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1] forState:UIControlStateNormal];
        [delete setBackgroundImage:[UIImage imageNamed:@"CancelBtn"] forState:UIControlStateNormal];
        [ContentView addSubview:delete];

        
        
//        UIButton *add =[[UIButton alloc]initWithFrame:CGRectMake(0.74*ContentView.width, 0.77*ContentView.height, 60, 40)];
//        [add setTitle:@"编辑" forState:UIControlStateNormal];
//        [add setTitleColor:[UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1] forState:UIControlStateNormal];
//        [add setBackgroundImage:[UIImage imageNamed:@"CancelBtn"] forState:UIControlStateNormal];
//        [ContentView addSubview:add];
        
        
      
        
        
        UILabel *showHand =[[UILabel alloc]initWithFrame:CGRectMake(0.048*ContentView.width, 0.69*ContentView.height, 70, 18)];
        showHand.text=@"投注金额";
        showHand.textColor =JWColorA(124, 124, 124, 1);
        [ContentView addSubview:showHand];
        
        UIImage *setLeft =[UIImage imageNamed:@"chooseSlider"];
        UIImage *setRigth =[UIImage imageNamed:@"sliderLine"];
        //滑动块图片
        UIImage *thumbImage =[UIImage imageNamed:@"sliderBall"];
        //滑动器
        self.slider =[[UISlider alloc]initWithFrame:CGRectMake(0.284 *ContentView.width, 0.695*ContentView.height, 164, 16)];
        self.slider.backgroundColor =[UIColor clearColor];
        self.slider.value =0.5;
        self.slider.minimumValue =0.0;
        self.slider.maximumValue =1.0;
        [self.slider setMinimumTrackImage:setLeft forState:UIControlStateNormal];
        [self.slider setMaximumTrackImage:setRigth forState:UIControlStateNormal];
        //这里要加UIControlStateHighlighted的状态，不然在滑动的时候会变回原生的状态
        [self.slider setThumbImage:thumbImage forState:UIControlStateHighlighted];
        [self.slider setThumbImage:thumbImage forState:UIControlStateNormal];
        [ContentView addSubview:self.slider];
        //滑块拖动时的事件
        [self.slider addTarget:self action:@selector(sliderValue:) forControlEvents:UIControlEventValueChanged];
        self.slider.userInteractionEnabled =NO;
        
        
        self.showHandRight =[[UILabel alloc]initWithFrame:CGRectMake(0.824*ContentView.width, 0.69*ContentView.height, 70, 18)];
        self.showHandRight.text=[NSString stringWithFormat:@"(%.2f)",self.slider.value];
        self.showHandRight.textColor =JWColorA(124, 124, 124, 1);
        [ContentView addSubview:self.showHandRight];
        
        self.AllShowHand =[[UIButton alloc]initWithFrame:CGRectMake(0.26*ContentView.width, 0.76*ContentView.height, 71, 43)];
        [self.AllShowHand setTitle:@"梭哈" forState:UIControlStateNormal];
        [self.AllShowHand setTitleColor:[UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1] forState:UIControlStateNormal];
        [self.AllShowHand setBackgroundImage:[UIImage imageNamed:@"CancelBtn"] forState:UIControlStateNormal];
        self.AllShowHand.titleLabel.font =[UIFont systemFontOfSize:16];
        [ContentView addSubview:self.AllShowHand];
        
       self.AgainstChoose =[[UIButton alloc]initWithFrame:CGRectMake(0.53*ContentView.width, 0.76*ContentView.height, 71, 43)];
        [self.AgainstChoose setTitle:@"反选" forState:UIControlStateNormal];
        [self.AgainstChoose setTitleColor:[UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1] forState:UIControlStateNormal];
        [self.AgainstChoose setBackgroundImage:[UIImage imageNamed:@"CancelBtn"] forState:UIControlStateNormal];
        self.AgainstChoose.titleLabel.font =[UIFont systemFontOfSize:16];
        [ContentView addSubview:self.AgainstChoose];
        
//        UIButton *Money =[[UIButton alloc]initWithFrame:CGRectMake(0.71*ContentView.width, 0.78*ContentView.height, 71, 43)];
//        [Money setTitle:@"输入金额" forState:UIControlStateNormal];
//        [Money setTitleColor:[UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1] forState:UIControlStateNormal];
//        [Money setBackgroundImage:[UIImage imageNamed:@"BetDefault"] forState:UIControlStateNormal];
//        Money.titleLabel.font =[UIFont systemFontOfSize:16];
//        [ContentView addSubview:Money];

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
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    for (int i =0; i<8; i++) {
        UIButton *button =[self viewWithTag:(i+1) * 100001];
        if (button.selected) {
             [button setTitle:textField.text forState:UIControlStateNormal];
        }
       
    }
    [self.ModelName1 resignFirstResponder];
    return YES;
}
//编辑模式
- (void)editingClick:(UIButton *)Edit{
    Edit.selected =!Edit.selected;
    if (Edit.selected) {
        for (int i =0; i<8; i++) {
            UIButton *button =[self viewWithTag:(i+1) * 100001];
            button.userInteractionEnabled =YES;
            [button addTarget:self action:@selector(modelClick:) forControlEvents:UIControlEventTouchUpInside];
            
            if (button.selected) {
                for (int i =0; i<28; i++) {
                    UIButton *button =[self viewWithTag:(i+1) * 10000];
                    button.userInteractionEnabled =YES;
                    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
                }
                //模式名称用户交互开启
                self.ModelName1.userInteractionEnabled =YES;
                //投注梭哈用户交互开启
                self.slider.userInteractionEnabled =YES;
            }
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
         self.ModelName1.userInteractionEnabled =NO;
        
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
    if (sender.selected) {
        for (int i =0; i<28; i++) {
            UIButton *button =[self viewWithTag:(i+1) * 10000];
            button.userInteractionEnabled =YES;
            [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        //模式名称用户交互开启
         self.ModelName1.userInteractionEnabled =YES;
        //投注梭哈用户交互开启
        self.slider.userInteractionEnabled =YES;
        
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
        [self.BetArray addObject:sender.currentTitle];
    } else{
        [sender setTitleColor:[UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1]  forState:UIControlStateNormal];
        [self.BetArray removeObject:sender.currentTitle];
    }
    
    NSLog(@"%@",self.BetArray);
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
