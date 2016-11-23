//
//  JWMyModelPopView.m
//  Lucky28
//
//  Created by 九旺网络 on 2016/11/10.
//  Copyright © 2016年 Jiuwang. All rights reserved.
//

#import "JWMyModelPopView.h"

@interface JWMyModelPopView ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
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

@property (nonatomic, strong) UITableView *TableView;

@property (nonatomic, strong) NSArray *BtnArray;

@property (nonatomic, strong) NSMutableDictionary *ModelBetDic;

@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic, strong) NSString *countStr;
@end
@implementation JWMyModelPopView

- (NSMutableDictionary *)ModelBetDic{
    if (!_ModelBetDic) {
        _ModelBetDic =[NSMutableDictionary dictionary];
    }
    return _ModelBetDic;
}
- (NSMutableArray *)ModelArray{
    if (!_ModelArray) {
        _ModelArray =[NSMutableArray array];
    }
    return _ModelArray;
}

- (UITableView *)TableView{
    if (!_TableView) {
        _TableView =[[UITableView  alloc]initWithFrame:CGRectMake(20, 15, SCREEN_WIDTH - 40, SCREEN_HEIGHT -45)];
        _TableView.layer.cornerRadius =5;
        _TableView.layer.masksToBounds =YES;
        _TableView.showsVerticalScrollIndicator =NO;

    }
    return _TableView;
}
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
        self.TableView.delegate =self;
        self.TableView.dataSource =self;
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ModelPop:) name:@"ModelPop" object:nil];//定额说梭哈

        //背景遮盖
        UIView *backView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        backView.backgroundColor = [UIColor blackColor];
        backView.alpha = 1;
        [self addSubview:backView];
        [backView addSubview:self.TableView];
        self.TableView.backgroundColor =JWColorA(255, 255, 255, 1);
        
        ;
    }    return self;
}
- (void)ModelPop:(NSNotification *)Noti{
    NSDictionary *dic =Noti.userInfo;
     //NSLog(@"😁😁😁😁😁%@",dic);
        AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
        manager.responseSerializer.acceptableContentTypes =[manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/json"];
    
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        NSString *url =[INDEXURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
        NSString *gametype =dic[@"ModelPop"];
        [parameters setObject:gametype forKey:@"type"];
        [parameters setObject:@"34260172" forKey:@"user_number"];
        [parameters setObject:@"1" forKey:@"page"];
        self.Style =gametype;
//         NSLog(@"😁%@",parameters);
        [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
    
        }success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            self.ModelArray = responseObject[@"data"];
            [self.TableView reloadData];
            NSLog(@"😁%@",responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"❌%@",error);
        }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // if (section == 0) return 1;
    //if (section == 1) return self.ModelArray.count;
    
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *Id =@"Cell";
    UITableViewCell *cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:Id];
    
    if (indexPath.section == 0) {//我的模式
        UILabel *MyName =[[UILabel alloc]initWithFrame:CGRectMake(self.TableView.width/2 -50,self.TableView.height *0.0303, 100, 20)];
        MyName.text =@"我的模式";
        
        MyName.font =[UIFont systemFontOfSize:20];
        MyName.textAlignment =NSTextAlignmentCenter;
        MyName.textColor =[UIColor blackColor];
        [cell addSubview:MyName];
    } else if (indexPath.section == 1){//模式
        NSString *name;
        for (int i=0; i<self.ModelArray.count; i++) {
            name =[NSString stringWithFormat:@"%@",self.ModelArray[i][@"mode_name"]];
            NSLog(@"🏷%@",name);
            int a = (i / 4);
            CGFloat BtnX = (i % 4)  *  ((SCREEN_WIDTH -40)*0.2 + (SCREEN_WIDTH -40)*0.048) +((SCREEN_WIDTH -40)*0.0298);
            CGFloat BtnY = a *60 +10;
            CGFloat BtnWidth =(SCREEN_WIDTH -40)*0.2;
            CGFloat BtnHeight = 50;
            UIButton *button =[[UIButton alloc]initWithFrame:CGRectMake(BtnX, BtnY, BtnWidth, BtnHeight)];
            [button setTitle:name forState:UIControlStateNormal];
            button.titleLabel.font =[UIFont systemFontOfSize:12];
            [button setTitleColor:[UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1]  forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"BetBox"] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"ChooseBet"] forState:UIControlStateSelected];
            [button addTarget:self action:@selector(ModleClick:) forControlEvents:UIControlEventTouchUpInside];
            button.titleLabel.numberOfLines =0;
            [cell addSubview:button];
            
        }
        
        
    }else if (indexPath.section == 2){
        self.countStr =[NSString CodeForType:self.Style];
        
        //投注按钮
        for (int i = 0; i < [self.countStr intValue]; i++) {
            int a = (i / 4);
            CGFloat BtnX = (i % 4)*((SCREEN_WIDTH -40) *0.138 +34) + 30;
            CGFloat BtnY = a*80 +10;
            CGFloat BtnWidth = 34;
            CGFloat BtnHeight =34;
            CGFloat TextFX = (i % 4)*((SCREEN_WIDTH -40) *0.12 +40) + 10;
            CGFloat TextFY = a*80 +50;
            CGFloat TextFWidth =70;
            CGFloat TextFHeight =30;
            UIButton *button =[[UIButton alloc]initWithFrame:CGRectMake(BtnX, BtnY, BtnWidth, BtnHeight)];
            UITextField *textfield =[[UITextField alloc]initWithFrame:CGRectMake(TextFX, TextFY, TextFWidth, TextFHeight)];
            textfield.tag =(i+1) * 10001;
            button.tag =(i+1) * 10000;
            textfield.placeholder =@"输入金额";
            textfield.textAlignment =NSTextAlignmentCenter;
            [textfield setFont:[UIFont systemFontOfSize:10]];
            textfield.borderStyle = UITextBorderStyleRoundedRect;
            [button setTitle:[NSString stringWithFormat:@"%d",i] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"placeholderNumber"] forState:UIControlStateNormal];
            [cell addSubview:button];
            [cell addSubview:textfield];
        }
       
    }else if (indexPath.section == 3){
        UILabel *text =[[UILabel alloc]initWithFrame:CGRectMake(10, 20, (SCREEN_WIDTH -40)*0.25, 30)];
        text.text =@"模式名称";
        UITextField *textField =[[UITextField alloc]initWithFrame:CGRectMake(text.width +20, 20, (SCREEN_WIDTH -40)*0.35, 30)];
        textField.borderStyle =UITextBorderStyleRoundedRect;
        UIButton *button =[[UIButton alloc]initWithFrame:CGRectMake(textField.X +textField.width +10, 10, (SCREEN_WIDTH -40)*0.2, 50)];
        [button setBackgroundImage:[UIImage imageNamed:@"YesBtn"] forState:UIControlStateNormal];
        [button setTitle:@"编辑" forState:UIControlStateNormal];
       
        for (int i =0; i<4; i++) {
            CGFloat BtnX = i *  ((SCREEN_WIDTH -40)*0.2 + (SCREEN_WIDTH -40)*0.048) +((SCREEN_WIDTH -40)*0.0298);
            CGFloat BtnY = 70;
            CGFloat BtnWidth =(SCREEN_WIDTH -40)*0.2;
            CGFloat BtnHeight = 40;
            UIButton *btn =[[UIButton alloc]initWithFrame:CGRectMake(BtnX, BtnY, BtnWidth, BtnHeight)];
            if (i == 0) {
               [btn setTitle:@"反选" forState:UIControlStateNormal];
            } else if (i == 1){
                 [btn setTitle:@"删除" forState:UIControlStateNormal];
            }else if (i == 2){
                 [btn setTitle:@"新增" forState:UIControlStateNormal];
            } else{
                 [btn setTitle:@"保存" forState:UIControlStateNormal];
            }
            
            [btn setBackgroundImage:[UIImage imageNamed:@"BetBox"] forState:UIControlStateNormal];
           [btn setTitleColor:[UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1] forState:UIControlStateNormal];
            [cell addSubview:btn];
        }
        [cell addSubview:text];
        [cell addSubview:textField];
        [cell addSubview:button];
    } else{
        for (int i =0; i<2; i++) {
            CGFloat BtnX = i *  ((SCREEN_WIDTH -40)*0.2 + (SCREEN_WIDTH -40)*0.15) +(((SCREEN_WIDTH -40) -  ((SCREEN_WIDTH -40)*0.4 + (SCREEN_WIDTH -40)*0.15)))/2;
            CGFloat BtnY = 10;
            CGFloat BtnWidth =(SCREEN_WIDTH -40)*0.2;
            CGFloat BtnHeight = 50;
            UIButton *btn =[[UIButton alloc]initWithFrame:CGRectMake(BtnX, BtnY, BtnWidth, BtnHeight)];
            if (i == 0) {
                [btn setTitle:@"确认" forState:UIControlStateNormal];
                 [btn setBackgroundImage:[UIImage imageNamed:@"YesBtn"] forState:UIControlStateNormal];
                 [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            } else{
                 [btn setTitle:@"取消" forState:UIControlStateNormal];
                 [btn setBackgroundImage:[UIImage imageNamed:@"BetBox"] forState:UIControlStateNormal];
                 [btn setTitleColor:[UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1] forState:UIControlStateNormal];
            }
            [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
           
            [cell addSubview:btn];
        }
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 60;
    } else if (indexPath.section == 1){
        NSInteger a = ceilf(self.ModelArray.count/ 4.0);
        NSLog(@"--------%ld %ld",self.ModelArray.count,a);
        return (a) *60 +10;
    }else if (indexPath.section == 2){
        if ([self.countStr intValue] == 5 ) {
            return 165;
        } else if ([self.countStr intValue] == 11){
            return 248;
        }else if ([self.countStr intValue] == 16){
            return 331;
        } else{
             return 580;
        }
       
    }else if (indexPath.section == 3){
        return 120;
    }else{
        return 70;
    }
}

- (void)ModleClick:(UIButton *)sender{ //模式点击
    
    sender.selected =YES;
    self.selectBtn.selected =NO;
    
    self.selectBtn =sender;
    
    NSString *name;
    NSString *Number;
    NSString *selectNumber;
    for (int i=0; i<self.ModelArray.count; i++) {
    name =[NSString stringWithFormat:@"%@",self.ModelArray[i][@"mode_name"]];
        if ([name isEqualToString:sender.currentTitle]) {
            self.ModelBetDic =self.ModelArray[i];
            NSLog(@"%@",self.ModelBetDic);
            for (int i=0; i<[self.countStr intValue]; i++) {
                UIButton *button =[self viewWithTag:(i+1) * 10000];
                UITextField *text =[self viewWithTag:(i+1) * 10001];
                Number =[NSString stringWithFormat:@"bet_number%@",button.currentTitle];
                selectNumber =[self.ModelBetDic objectForKey:Number];
                    [button setBackgroundImage:[UIImage imageNamed:@"placeholderNumber"] forState:UIControlStateNormal];//全部复原
                [button setTitleColor:[UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1] forState:UIControlStateNormal];
                    text.text =@"";
                if ([selectNumber integerValue] >0) {
                    [button setBackgroundImage:[UIImage imageNamed:@"Number_back"] forState:UIControlStateNormal];//设置
                    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    text.text =selectNumber;
                }
                
               
            }
            
        }
    }
    
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
        sender.titleLabel.font =[UIFont systemFontOfSize:11];
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
        self.Model =[NSMutableDictionary dictionary];
        [self.Model setObject:self.BetArray forKey:@"Nmuber"];//投注号码
        [self.Model setObject:self.ModelName1.text forKey:@"Name"];//投注名称
        [self.Model setObject:[NSString stringWithFormat:@"%0.2f",self.slider.value] forKey:@"Money"];//投注金额
        [self.customModel addObject:self.Model];
        NSLog(@"++++++%@",self.customModel);
    }
    self.hidden =YES;
}
- (void)show{
    [self makeKeyAndVisible];
    
}
-(void)viewDidLayoutSubviews {
    
    if ([self.TableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.TableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([self.TableView respondsToSelector:@selector(setLayoutMargins:)])  {
        [self.TableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
}
@end
