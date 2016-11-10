//
//  BetDefaultPopView.m
//  Lucky28
//
//  Created by 九旺网络 on 2016/11/2.
//  Copyright © 2016年 Jiuwang. All rights reserved.
//

#import "BetDefaultPopView.h"

@interface BetDefaultPopView ()
@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic, strong) NSArray *BtnContentArray;
@property (nonatomic, strong) NSMutableArray * chooseBetArray;
@end

@implementation BetDefaultPopView

- (NSArray *)chooseBetArray{
    if (!_chooseBetArray) {
        _chooseBetArray =[NSMutableArray array];
    }
    return _chooseBetArray;
}
- (NSArray *)BtnContentArray{
    if (!_BtnContentArray) {
        _BtnContentArray =[NSArray arrayWithObjects:@"大", @"小",@"单",@"双",@"中",@"边",@"大单",@"小单",@"大双",@"小双",@"大边",@"小边",@"0尾",@"1尾",@"2尾",@"3尾",@"4尾",@"5尾",@"6尾",@"7尾",@"8尾",@"9尾",@"大尾",@"3余0",@"3余1",@"3余2",@"4余0",@"4余1",@"4余2",@"4余3",@"5余0",@"5余1",@"5余2",@"5余3",@"5余4",@"确定",nil];
    }
    return _BtnContentArray;
}
- (void)setBetName:(NSInteger)betName{
    _betName =betName;
  
}
- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self =[super initWithFrame:frame]) {
        self.windowLevel =UIWindowLevelAlert;
       
        //背景遮盖
        UIView *backView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        backView.backgroundColor = [UIColor blackColor];
        backView.alpha = 0.7;
        [self addSubview:backView];
        //正真视图层
        UIView *ContentView = [[UIView alloc] initWithFrame:CGRectMake(20, 85, SCREEN_WIDTH - 40, SCREEN_HEIGHT -140)];
        ContentView.backgroundColor =JWColorA(245, 245, 245, 1);
        ContentView.layer.cornerRadius =5;
        ContentView.layer.masksToBounds =YES;
        [self addSubview:ContentView];
        for (int i = 0; i <36; i++) {
            
            int a = (i / 4);
            CGFloat BtnX = (i % 4)*80 + 10;
            CGFloat BtnY = a*48 +90;
            CGFloat BtnWidth = 70;
            CGFloat BtnHeight =40;
            
            
            UIButton *button =[[UIButton alloc]initWithFrame:CGRectMake(BtnX, BtnY, BtnWidth, BtnHeight)];
            button.tag =(i+1) * 10000;
            [button setTitle:self.BtnContentArray[i] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1] forState:UIControlStateNormal];
            if (i <35) {
                [button setBackgroundImage:[UIImage imageNamed:@"BetDefault"] forState:UIControlStateNormal];
                [button setBackgroundImage:[UIImage imageNamed:@"ChooseBet"] forState:UIControlStateSelected];
            }else{
                [button setBackgroundImage:[UIImage imageNamed:@"BetLoading"] forState:UIControlStateNormal];
                [button setBackgroundImage:[UIImage imageNamed:@"BetLoading"] forState:UIControlStateSelected];
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }
            
           
              NSLog(@"----%ld",self.betName);
            [button addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
            [ContentView addSubview:button];
            
        }
        
       
        
    }
    return self;
}
- (void)choose:(UIButton *)sender{
    [self.chooseBetArray removeAllObjects];
    if ([sender.currentTitle isEqualToString:@"大"]) {
        for (int i = 0; i <28; i++) {
            if (i > 13) {
                [self.chooseBetArray addObject: [NSString stringWithFormat:@"%d",i]];
            }
            
        }
        
    } else if ([sender.currentTitle isEqualToString:@"小"]){
        for (int i = 0; i <28; i++) {
            if (i < 14) {
                [self.chooseBetArray addObject: [NSString stringWithFormat:@"%d",i]];
            }
            
        }
    }else if ([sender.currentTitle isEqualToString:@"单"]){
        for (int i = 0; i <28; i++) {
            
            if (i%2 != 0) {
                [self.chooseBetArray addObject: [NSString stringWithFormat:@"%d",i]];
            }
            
        }
    }else if ([sender.currentTitle isEqualToString:@"双"]){
        for (int i = 0; i <28; i++) {
            
            if (i%2 == 0) {
                [self.chooseBetArray addObject: [NSString stringWithFormat:@"%d",i]];
            }
            
        }
    }else if ([sender.currentTitle isEqualToString:@"中"]){
        for (int i = 0; i <28; i++) {
            
            if (i < 18 && i >9) {
                [self.chooseBetArray addObject: [NSString stringWithFormat:@"%d",i]];
            }
            
        }
        
        
    }else if ([sender.currentTitle isEqualToString:@"边"]){
        for (int i = 0; i <28; i++) {
            
            if ((i<= 28 && i> 17) || (i<= 9 && i>= 0)) {
                [self.chooseBetArray addObject: [NSString stringWithFormat:@"%d",i]];
            }
            
        }
        
    }else if ([sender.currentTitle isEqualToString:@"大单"]){
        for (int i = 0; i <28; i++) {
            
            if (i<= 28 && i> 17 && i%2!=0) {
                [self.chooseBetArray addObject: [NSString stringWithFormat:@"%d",i]];
            }
            
        }
    }else if ([sender.currentTitle isEqualToString:@"小单"]){
        for (int i = 0; i <28; i++) {
            
            if (i<= 9 && i>= 0 && i%2!=0) {
                [self.chooseBetArray addObject: [NSString stringWithFormat:@"%d",i]];
            }
            
        }
    }else if ([sender.currentTitle isEqualToString:@"大双"]){
        for (int i = 0; i <28; i++) {
            
            if (i<= 28 && i> 17 && i%2==0) {
                [self.chooseBetArray addObject: [NSString stringWithFormat:@"%d",i]];
            }
            
        }
    }else if ([sender.currentTitle isEqualToString:@"小双"]){
        for (int i = 0; i <28; i++) {
            
            if (i<= 9 && i>= 0 && i%2==0) {
                [self.chooseBetArray addObject: [NSString stringWithFormat:@"%d",i]];
            }
            
        }
    }else if ([sender.currentTitle isEqualToString:@"大边"]){
        for (int i = 0; i <28; i++) {
            
            if (i<= 28 && i> 17) {
                [self.chooseBetArray addObject: [NSString stringWithFormat:@"%d",i]];
            }
            
        }
        
    }else if ([sender.currentTitle isEqualToString:@"小边"]){
        for (int i = 0; i <28; i++) {
            
            if ( i<= 9 && i>= 0) {
                [self.chooseBetArray addObject: [NSString stringWithFormat:@"%d",i]];
            }
            
        }
        
    }else if ([sender.currentTitle isEqualToString:@"0尾"]){
        for (int i = 0; i <28; i++) {
            if (i%10 ==0) {
                [self.chooseBetArray addObject: [NSString stringWithFormat:@"%d",i]];
            }
        }
    }else if ([sender.currentTitle isEqualToString:@"1尾"]){
        for (int i = 0; i <28; i++) {
            if (i%10 ==1) {
                [self.chooseBetArray addObject: [NSString stringWithFormat:@"%d",i]];
            }
        }
    }else if ([sender.currentTitle isEqualToString:@"2尾"]){
        for (int i = 0; i <28; i++) {
            if (i%10 ==2) {
                [self.chooseBetArray addObject: [NSString stringWithFormat:@"%d",i]];
            }
        }
    }else if ([sender.currentTitle isEqualToString:@"3尾"]){
        for (int i = 0; i <28; i++) {
            if (i%10 ==3) {
                [self.chooseBetArray addObject: [NSString stringWithFormat:@"%d",i]];
            }
        }
    }else if ([sender.currentTitle isEqualToString:@"4尾"]){
        for (int i = 0; i <28; i++) {
            if (i%10 ==4) {
                [self.chooseBetArray addObject: [NSString stringWithFormat:@"%d",i]];
            }
        }
    }else if ([sender.currentTitle isEqualToString:@"5尾"]){
        for (int i = 0; i <28; i++) {
            if (i%10 ==5) {
                [self.chooseBetArray addObject: [NSString stringWithFormat:@"%d",i]];
            }
        }
    }else if ([sender.currentTitle isEqualToString:@"6尾"]){
        for (int i = 0; i <28; i++) {
            if (i%10 ==6) {
                [self.chooseBetArray addObject: [NSString stringWithFormat:@"%d",i]];
            }
        }
    }else if ([sender.currentTitle isEqualToString:@"7尾"]){
        for (int i = 0; i <28; i++) {
            if (i%10 ==7) {
                [self.chooseBetArray addObject: [NSString stringWithFormat:@"%d",i]];
            }
        }
    }else if ([sender.currentTitle isEqualToString:@"8尾"]){
        for (int i = 0; i <28; i++) {
            if (i%10 ==8) {
                [self.chooseBetArray addObject: [NSString stringWithFormat:@"%d",i]];
            }
        }
    }else if ([sender.currentTitle isEqualToString:@"9尾"]){
        for (int i = 0; i <28; i++) {
            if (i%10 ==9) {
                [self.chooseBetArray addObject: [NSString stringWithFormat:@"%d",i]];
            }
        }
    }else if ([sender.currentTitle isEqualToString:@"大尾"]){
        for (int i = 0; i <28; i++) {
            if (i%10 >=5) {
                [self.chooseBetArray addObject: [NSString stringWithFormat:@"%d",i]];
            }
        }
        
    }else if ([sender.currentTitle isEqualToString:@"3余0"]){
        for (int i = 0; i <28; i++) {
            if (i%3 ==0) {
                [self.chooseBetArray addObject: [NSString stringWithFormat:@"%d",i]];
            }
        }
    }else if ([sender.currentTitle isEqualToString:@"3余1"]){
        for (int i = 0; i <28; i++) {
            if (i%3 ==1) {
                [self.chooseBetArray addObject: [NSString stringWithFormat:@"%d",i]];
            }
        }
    }else if ([sender.currentTitle isEqualToString:@"3余2"]){
        for (int i = 0; i <28; i++) {
            if (i%3 ==2) {
                [self.chooseBetArray addObject: [NSString stringWithFormat:@"%d",i]];
            }
        }
    }else if ([sender.currentTitle isEqualToString:@"4余0"]){
        for (int i = 0; i <28; i++) {
            if (i%4 ==0) {
                [self.chooseBetArray addObject: [NSString stringWithFormat:@"%d",i]];
            }
        }
        
    }else if ([sender.currentTitle isEqualToString:@"4余1"]){
        for (int i = 0; i <28; i++) {
            if (i%4 ==1) {
                [self.chooseBetArray addObject: [NSString stringWithFormat:@"%d",i]];
            }
        }
    }else if ([sender.currentTitle isEqualToString:@"4余2"]){
        for (int i = 0; i <28; i++) {
            if (i%4 ==2) {
                [self.chooseBetArray addObject: [NSString stringWithFormat:@"%d",i]];
            }
        }
    }else if ([sender.currentTitle isEqualToString:@"4余3"]){
        for (int i = 0; i <28; i++) {
            if (i%4 ==3) {
                [self.chooseBetArray addObject: [NSString stringWithFormat:@"%d",i]];
            }
        }
    }else if ([sender.currentTitle isEqualToString:@"5余0"]){
        for (int i = 0; i <28; i++) {
            if (i%5 ==0) {
                [self.chooseBetArray addObject: [NSString stringWithFormat:@"%d",i]];
            }
        }
    }else if ([sender.currentTitle isEqualToString:@"5余1"]){
        for (int i = 0; i <28; i++) {
            if (i%5 ==1) {
                [self.chooseBetArray addObject: [NSString stringWithFormat:@"%d",i]];
            }
        }
    }else if ([sender.currentTitle isEqualToString:@"5余2"]){
        for (int i = 0; i <28; i++) {
            if (i%5 ==2) {
                [self.chooseBetArray addObject: [NSString stringWithFormat:@"%d",i]];
            }
        }
    }else if ([sender.currentTitle isEqualToString:@"5余3"]){
        for (int i = 0; i <28; i++) {
            if (i%5 ==3) {
                [self.chooseBetArray addObject: [NSString stringWithFormat:@"%d",i]];
            }
        }
    }else if ([sender.currentTitle isEqualToString:@"5余4"]){
        for (int i = 0; i <28; i++) {
            if (i%5 ==4) {
                [self.chooseBetArray addObject: [NSString stringWithFormat:@"%d",i]];
            }
        }
    }
    
    if ([sender.currentTitle isEqualToString:@"确定"]) {
        
        self.hidden =YES;
    }else{
       
        if (self.betArray) {
            self.betArray(self.chooseBetArray,sender.tag);
        }

        sender.selected =!sender.selected;
        if (self.selectBtn ==  sender) {
            return;
        }
        self.selectBtn.selected =NO;
        self.selectBtn =sender;
    }
    
    
  }
- (void)handleForBetType:(BlockBetType)block{
    self.betArray =block;
}

- (void)show{
    [self makeKeyAndVisible];
}
- (void)dismiss{
    [self resignKeyWindow];
    [self removeFromSuperview];
}
@end
