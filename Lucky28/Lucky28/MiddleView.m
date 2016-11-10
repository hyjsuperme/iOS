//
//  MiddleView.m
//  Lucky28
//
//  Created by 九旺网络 on 2016/10/26.
//  Copyright © 2016年 Jiuwang. All rights reserved.
//

#import "MiddleView.h"
#import "BetDefaultPopView.h"


@interface MiddleView ()
{
    /**选中时的button*/
    UIButton *currentSelected;
    UILabel *label1;
    UILabel *label2;
    UILabel *label3;
    //NSMutableArray * buttonArray;
}
@property (nonatomic, strong) BetDefaultPopView *PopView;
@property (nonatomic, strong) NSMutableArray *buttonArray;
@end
@implementation MiddleView
- (NSMutableArray *)buttonArray{
    if (!_buttonArray) {
        _buttonArray =[NSMutableArray array];
    }
    return _buttonArray;
}


- (instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        //设置按钮
       
        [self setButton];
    }
    return self;
}

- (void)setButton{
    UIButton *Btn =NULL;
    CGFloat width =SCREEN_WIDTH /3;
    NSArray *array =[NSArray arrayWithObjects:@"游戏中心",@"开奖信息",@"最新资讯", nil];
    for (int i =0; i <3; i++) {
        Btn =[UIButton buttonWithType:UIButtonTypeCustom];
        Btn.frame =CGRectMake(i *width, 0, width, SCREEN_HEIGHT *0.06);
        Btn.tag =i+11;
        [Btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        Btn.titleLabel.textAlignment =NSTextAlignmentCenter;
        Btn.titleLabel.font =[UIFont systemFontOfSize:17.0f];
        [Btn setBackgroundColor:[UIColor whiteColor]];
        [Btn setUserInteractionEnabled:YES];
        [Btn setTitle:array[i] forState:UIControlStateNormal];
        [Btn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:Btn];
        [self.buttonArray addObject:Btn];
            if (i == 0) {
            currentSelected =Btn;
            label1=[[UILabel alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT *0.06 - 5, width, 5)];
            label1.backgroundColor =JWColorA(234, 169, 68, 1);
            [self addSubview:label1];
        } else if (i == 1){
            label2=[[UILabel alloc]initWithFrame:CGRectMake(width, SCREEN_HEIGHT *0.06 - 5, width, 5)];
            label2.backgroundColor =[UIColor whiteColor];
            [self addSubview:label2];
        } else{
            label3=[[UILabel alloc]initWithFrame:CGRectMake(width *2, SCREEN_HEIGHT *0.06 - 5, width, 5)];
             label3.backgroundColor =[UIColor whiteColor];
            [self addSubview:label3];
        }
    }
    UILabel *headLine =[[UILabel alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT *0.06 - 1, SCREEN_WIDTH, 1)];
    headLine.backgroundColor =JWColorA(238, 238, 238, 1);
    [self addSubview:headLine];

    
}
/**按钮点击*/
- (void)BtnClick:(UIButton *)sender{
   
    NSInteger viewTag =[sender tag];
//    if (viewTag == 13) {
//        BetDefaultPopView *popView =[[BetDefaultPopView alloc]initWithFrame:[UIScreen mainScreen].bounds];
//        [popView makeKeyAndVisible];
//        //[popView show];
//        NSLog(@"---");
//    }
    if ([currentSelected isEqual: sender]) {
        
        return;
    } else{
        currentSelected =sender;
    }
    
         [self refreshView:viewTag];

    if (self.index) {
        self.index(viewTag);
    }
 
}

/**刷新界面*/
- (void)refreshView:(NSInteger)Index{
   
    
    for (UIButton *btn in self.buttonArray) {
        
        if (btn.tag ==Index) {
            if (btn.tag == 11) {
                //深绿
                label1.backgroundColor=JWColorA(234, 169, 68, 1);
            }else if(btn.tag==12){
                label2.backgroundColor=JWColorA(234, 169, 68, 1);
            }else{
                label3.backgroundColor=JWColorA(234, 169, 68, 1);
            }

        } else{
            
           
            if (btn.tag == 11) {
                //深绿
                label1.backgroundColor=[UIColor whiteColor];
            }else if(btn.tag==12){
                label2.backgroundColor=[UIColor whiteColor];
            }else{
                label3.backgroundColor=[UIColor whiteColor];
            }
     

        }
    }
}





- (void)HandleCurrentIndex:(Block_Index)block{
    self.index =block;
}
@end
