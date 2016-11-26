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
/**新增*/
@property (nonatomic, strong) NSMutableDictionary *NewAdd;
/**模式名称*/
@property (nonatomic, strong) NSString *selectModelName;
/**添加还是编辑*/
@property (nonatomic, strong) NSString *btnStyle;
/**新增号码*/
@property (nonatomic, strong) NSMutableArray *Number;
@property (nonatomic, strong) NSArray *Number36;
//@property (nonatomic, strong) UIAlertController *alertVc;


/**弹窗1*/
@property (nonatomic, strong) UIView *AlertVc;
/**弹窗1*/
@property (nonatomic, strong) UILabel *message;


/**弹窗2*/
@property (nonatomic, strong) UIView *AlertVcBtn;
/**弹窗2*/
@property (nonatomic, strong) UILabel *messageBtn;


@property (nonatomic, strong) UIButton *lastBtn;

/**编辑按钮状态*/
@property (nonatomic, assign) BOOL Edit;
/**编辑按钮状态*/
@property (nonatomic, assign) NSInteger ModelEdit;

@property (nonatomic, strong) NSString *ModelID;

@property (nonatomic, strong) NSMutableDictionary *choose;

@end


@implementation JWMyModelPopView

- (NSMutableDictionary *)choose{
    if (!_choose) {
        _choose =[NSMutableDictionary dictionary];
    }
    return _choose;
}

- (UIView *)AlertVcBtn{
    if (!_AlertVcBtn) {
        _AlertVcBtn =[[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 100, SCREEN_HEIGHT, 200, 100)];
        _AlertVcBtn.layer.cornerRadius =5;
        _AlertVcBtn.layer.masksToBounds =YES;
        _AlertVcBtn.backgroundColor =[UIColor grayColor];
        UIView *view =[[UIView alloc]initWithFrame:CGRectMake(1, 1, 198, 98)];
        view.layer.cornerRadius =5;
        view.layer.masksToBounds =YES;
        view.backgroundColor =[UIColor whiteColor];
        [_AlertVcBtn addSubview:view];
        [_AlertVcBtn addSubview:self.messageBtn];
        UIButton *BtnYes =[[UIButton alloc]initWithFrame:CGRectMake(35, 60, 60, 30)];
        [BtnYes setBackgroundImage:[UIImage imageNamed:@"YesBtn"] forState:UIControlStateNormal];
        
        UIButton *BtnCancel =[[UIButton alloc]initWithFrame:CGRectMake(115, 60, 60, 30)];
        [BtnCancel setBackgroundImage:[UIImage imageNamed:@"BetLoading"] forState:UIControlStateNormal];
        [BtnYes setTitle:@"确定" forState:UIControlStateNormal];
        [BtnCancel setTitle:@"取消" forState:UIControlStateNormal];
        [_AlertVcBtn addSubview:BtnYes];
        [_AlertVcBtn addSubview:BtnCancel];
        [BtnYes addTarget:self action:@selector(BtnYesClick:) forControlEvents:UIControlEventTouchUpInside];
        [BtnCancel addTarget:self action:@selector(BtnYesClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
    }
    return _AlertVcBtn;
}
- (UILabel *)messageBtn{
    if (!_messageBtn) {
        _messageBtn =[[UILabel alloc]initWithFrame:CGRectMake(5, 10, 190, 25)];
        _messageBtn.layer.cornerRadius =5;
        _messageBtn.layer.masksToBounds =YES;
        _messageBtn.textAlignment =NSTextAlignmentCenter;
        
        
    }
    return _messageBtn;
}


- (UIView *)AlertVc{
    if (!_AlertVc) {
        _AlertVc =[[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 100, SCREEN_HEIGHT, 200, 70)];
        _AlertVc.layer.cornerRadius =5;
        _AlertVc.layer.masksToBounds =YES;
        _AlertVc.backgroundColor =[UIColor grayColor];
        [_AlertVc addSubview:self.message];
        
        
    }
    return _AlertVc;
}
- (UILabel *)message{
    if (!_message) {
        _message =[[UILabel alloc]initWithFrame:CGRectMake(1, 1, 198, 68)];
        _message.textAlignment =NSTextAlignmentCenter;
        _message.backgroundColor =[UIColor whiteColor];
        _message.layer.cornerRadius =5;
        _message.layer.masksToBounds =YES;
        
        
    }
    return _message;
}

- (NSArray*)Number36{
    if (!_Number36) {
        _Number36 =[NSArray arrayWithObjects:@"豹",@"顺",@"对",@"半",@"杂", nil];
    }
    return _Number36;
    
}
- (NSMutableArray *)Number{
    if (!_Number) {
        _Number =[NSMutableArray array];
    }
    return _Number;
}
- (NSMutableDictionary *)NewAdd{
    if (!_NewAdd) {
        _NewAdd =[NSMutableDictionary dictionary];
    }
    return _NewAdd;
}

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
        _TableView =[[UITableView  alloc]initWithFrame:CGRectMake(20, 22, SCREEN_WIDTH - 40, SCREEN_HEIGHT -45)];
        _TableView.layer.cornerRadius =5;
        _TableView.layer.masksToBounds =YES;
        _TableView.showsVerticalScrollIndicator =NO;
        _TableView.tableFooterView =[[UIView alloc]init];
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
    
        AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
        manager.responseSerializer.acceptableContentTypes =[manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/json"];
    
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        NSString *url =[INDEXURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
        NSString *gametype =dic[@"ModelPop"];
        [parameters setObject:gametype forKey:@"type"];
        [parameters setObject:@"34260172" forKey:@"user_number"];
        [parameters setObject:@"1" forKey:@"page"];
        self.Style =gametype;

        [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
    
        }success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            self.ModelArray = responseObject[@"data"];
            [self.TableView reloadData];
           
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
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
        for (int i=0; i<self.ModelArray.count+1; i++) {
          
          
            int a = (i / 4);
            CGFloat BtnX = (i % 4)  *  ((SCREEN_WIDTH -40)*0.2 + (SCREEN_WIDTH -40)*0.048) +((SCREEN_WIDTH -40)*0.0298);
            CGFloat BtnY = a *60 +10;
            CGFloat BtnWidth =(SCREEN_WIDTH -40)*0.2;
            CGFloat BtnHeight = 50;
            UIButton *button =[[UIButton alloc]initWithFrame:CGRectMake(BtnX, BtnY, BtnWidth, BtnHeight)];
            button.tag =(i +1)*20101;
            if (i < self.ModelArray.count) {
                  name =[NSString stringWithFormat:@"%@",self.ModelArray[i][@"mode_name"]];
                 [button setTitle:name forState:UIControlStateNormal];
                 [button setTitleColor:[UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1]  forState:UIControlStateNormal];
                 button.titleLabel.font =[UIFont systemFontOfSize:12];
            } else{
               
                [button setTitle:@" + " forState:UIControlStateNormal];
                 [button setTitleColor:[UIColor redColor]  forState:UIControlStateNormal];
                 button.titleLabel.font =[UIFont systemFontOfSize:30];
                button.tag =1977;
            }
            
            if (button.tag ==self.ModelEdit) {
                button.selected =YES;
            }
           
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
           // textfield.placeholder =@"输入金额";
            
            textfield.textAlignment =NSTextAlignmentCenter;
            [textfield setFont:[UIFont systemFontOfSize:10]];
            textfield.borderStyle = UITextBorderStyleNone;
            if ([self.countStr integerValue] != 5) { //判断游戏是否是36
                if ([self.countStr integerValue] == 11) {
                        [button setTitle:[NSString stringWithFormat:@"%d",i+2] forState:UIControlStateNormal];
                } else if ([self.countStr integerValue] == 16){
                        [button setTitle:[NSString stringWithFormat:@"%d",i+3] forState:UIControlStateNormal];
                } else{
                        [button setTitle:[NSString stringWithFormat:@"%d",i] forState:UIControlStateNormal];
                }
             
            } else {
                
                 [button setTitle:self.Number36[i] forState:UIControlStateNormal];
            }
           
            [button setTitleColor:[UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"placeholderNumber"] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"Number_back"] forState:UIControlStateSelected];
            [cell addSubview:button];
            [cell addSubview:textfield];
            button.userInteractionEnabled =NO;
            textfield.userInteractionEnabled =NO;
        }
       
    }else if (indexPath.section == 3){
        UILabel *text =[[UILabel alloc]initWithFrame:CGRectMake(10, 20, (SCREEN_WIDTH -40)*0.2, 30)];
        text.text =@"模式名称";
        text.font =[UIFont systemFontOfSize:14];
        UITextField *textField =[[UITextField alloc]initWithFrame:CGRectMake(text.width +10, 20, (SCREEN_WIDTH -40)*0.35, 30)];
        textField.borderStyle =UITextBorderStyleRoundedRect;
        UIButton *button =[[UIButton alloc]initWithFrame:CGRectMake(textField.X +textField.width +10, 15, (SCREEN_WIDTH -40)*0.2, 40)];
         UIButton *delete =[[UIButton alloc]initWithFrame:CGRectMake(button.X +button.width +5, 15, (SCREEN_WIDTH -40)*0.14, 40)];
        delete.tag =773;
        textField.tag =997;
        if ([self.btnStyle isEqualToString:@" + "]) {
            [button setBackgroundImage:[UIImage imageNamed:@"BetLoading"] forState:UIControlStateNormal];
//            [button setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateSelected];
            [button setTitle:@"添加" forState:UIControlStateNormal];
            textField.userInteractionEnabled =YES;
            textField.placeholder =@"请输入名称";
            
            [delete removeFromSuperview];
            
        } else{
            
            button.selected =self.Edit;
            [button setBackgroundImage:[UIImage imageNamed:@"YesBtn"] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"BetLoading"] forState:UIControlStateSelected];
            [button setTitle:@"编辑" forState:UIControlStateNormal];
            [button setTitle:@"保存" forState:UIControlStateSelected];
            [delete setTitle:@"删除" forState:UIControlStateNormal];
            [delete setBackgroundImage:[UIImage imageNamed:@"BetLoading"] forState:UIControlStateNormal];
            [delete addTarget:self action:@selector(deleteClick:) forControlEvents:UIControlEventTouchUpInside];
           // delete.userInteractionEnabled =NO;
            [cell addSubview:delete];
            delete.titleLabel.font =[UIFont systemFontOfSize:15];
            textField.userInteractionEnabled =NO;
            textField.text =self.selectModelName;
        }
        
        [button addTarget:self action:@selector(Edit:) forControlEvents:UIControlEventTouchUpInside]; //新增点击
        button.tag =557;
        [cell addSubview:text];
        [cell addSubview:textField];
        [cell addSubview:button];
        text.userInteractionEnabled =NO;
       
        
    } else{//确认取消
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
        NSInteger a = ceilf((self.ModelArray.count+1)/ 4.0);
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
        return 70;
    }else{
        return 70;
    }
}


- (void)ModleClick:(UIButton *)sender{ //模式点击
   // [self.TableView reloadData];
    sender.selected =YES;
    self.selectBtn.selected =NO;
    self.selectBtn =sender;
   UIButton *EditButton =[self viewWithTag:557];
    UITextField *feild =[self viewWithTag:997];
    feild.userInteractionEnabled =NO;
    feild.text =sender.currentTitle;
    self.selectModelName =sender.currentTitle;
    self.btnStyle =sender.currentTitle;
    NSLog(@"😁%@",sender.currentTitle);
    self.ModelEdit =sender.tag;
    
    if ([sender.currentTitle isEqualToString:@" + "] && sender.tag ==1977) {
        
        if (self.Number.count!=0) {
            [self.Number removeAllObjects];
        }
        for (int i=0; i<[self.countStr intValue]; i++) {
            UIButton *button =[self viewWithTag:(i+1) * 10000];
            UITextField *text =[self viewWithTag:(i+1) * 10001];
            
            [button setBackgroundImage:[UIImage imageNamed:@"placeholderNumber"] forState:UIControlStateNormal];//全部复原
            [button setTitleColor:[UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1] forState:UIControlStateNormal];
            button.selected =NO;
            text.text =@"";
            button.userInteractionEnabled =YES;
            text.placeholder =@"输入金额";
            text.borderStyle =UITextBorderStyleRoundedRect;
            [button addTarget:self action:@selector(NewEdit:) forControlEvents:UIControlEventTouchUpInside];
            [button setBackgroundImage:[UIImage imageNamed:@"placeholderNumber"] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"Number_back"] forState:UIControlStateSelected];
            
        }
        [EditButton setTitle:@"添加" forState:UIControlStateNormal];
        [EditButton setBackgroundImage:[UIImage imageNamed:@"BetLoading"] forState:UIControlStateNormal];
//        [button setBackgroundImage:[UIImage imageNamed:@"YesBtn"] forState:UIControlStateNormal];
//        [button setTitle:@"编辑" forState:UIControlStateNormal];
        
    } else{
        [EditButton setTitle:@"编辑" forState:UIControlStateNormal];
        [EditButton setBackgroundImage:[UIImage imageNamed:@"YesBtn"] forState:UIControlStateNormal];
        self.Edit =NO;
        NSString *name;
        NSString *Number;
        NSString *selectNumber;
        [self.Number removeAllObjects];
        for (int i=0; i<self.ModelArray.count; i++) {
            name =[NSString stringWithFormat:@"%@",self.ModelArray[i][@"mode_name"]];
            if ([name isEqualToString:sender.currentTitle]) {
                self.ModelBetDic =self.ModelArray[i];
                self.ModelID =[NSString stringWithFormat:@"%@",self.ModelBetDic[@"mode_id"]];
                NSLog(@"IDDDDDDD😁%@ ",self.ModelBetDic);
                for (int i=0; i<[self.countStr intValue]; i++) {
                    UIButton *button =[self viewWithTag:(i+1) * 10000];
                    UITextField *text =[self viewWithTag:(i+1) * 10001];
                    button.userInteractionEnabled =NO;
                    text.userInteractionEnabled =NO;
                    Number =[NSString stringWithFormat:@"bet_number%@",button.currentTitle];
                    selectNumber =[self.ModelBetDic objectForKey:Number];
                    [button setBackgroundImage:[UIImage imageNamed:@"placeholderNumber"] forState:UIControlStateNormal];//全部复原
                    button.selected =NO;
                    [button setTitleColor:[UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1] forState:UIControlStateNormal];
                    text.placeholder =@"";
                    text.text =@"";
                    text.borderStyle =UITextBorderStyleNone;
                    if ([selectNumber integerValue] >0) {
                        [self.Number addObject:button.currentTitle];
                        [button setBackgroundImage:[UIImage imageNamed:@"Number_back"] forState:UIControlStateNormal];//设置
                        button.selected =YES;
                        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                        text.text =selectNumber;
                    }
                    
                    
                }
                
            }
        }
    }
  
    self.lastBtn =sender;
}

- (void)NewEdit:(UIButton *)sender{//新增
    
    UIButton *button =[self viewWithTag:557];
    [button setBackgroundImage:[UIImage imageNamed:@"BetLoading"] forState:UIControlStateNormal];
    //[button setTitle:@"添加" forState:UIControlStateNormal];
    sender.selected =!sender.selected;
   
    UITextField *text =[self viewWithTag:(sender.tag/10000) * 10001];
    text.userInteractionEnabled =YES;
    NSString *str=[NSString stringWithFormat:@"%ld",(sender.tag/10000)-1];
    if (sender.selected) {
       text.userInteractionEnabled =YES;
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
       
       [self.Number addObject:str];
        
    } else{
         text.userInteractionEnabled =NO;
         [sender setTitleColor:[UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1] forState:UIControlStateNormal];
        [self.Number removeObject:str];
       
            UITextField *text =[self viewWithTag:(sender.tag/10000) * 10001];
        text.text=@"";
        
    }
    
    NSLog(@"%@",self.Number);
}

- (void)Edit:(UIButton *)sender{ //添加、编辑点击
    UITextField *text =[self viewWithTag:997];
    NSLog(@"%@",sender.currentTitle);
    if ([sender.currentTitle isEqualToString:@"添加"]) {
        
        NSLog(@"😑%ld",text.text.length);
        [self addSubview:self.AlertVc];
        if (text.text.length <1 ) {
            self.message.text =@"模式名称不能为空";
            [self PopMessage];
        }else if (self.Number.count ==0) {
            self.message.text =@"选号不能为空";
            [self PopMessage];
        } else{
            
            NSInteger Tag;
            NSString *number;
            for (int i = 0; i<self.Number.count; i++) {//选中号码
                Tag =([self.Number[i] integerValue] +1) *10001;
                UITextField *field =[self viewWithTag:Tag];
                if (field.text.length <1) {
                    self.message.text =@"金额不能为空";
                    [self PopMessage];
                    return;
                }
            }
            AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
            manager.responseSerializer.acceptableContentTypes =[manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/json"];
            
            NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
            NSString *url =[CREATEURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            
            [parameters setObject:self.Style forKey:@"game_type"];
            [parameters setObject:@"34260172" forKey:@"user_number"];
            [parameters setObject:text.text forKey:@"mode_name"];
            
            
            for (int i = 0; i<self.Number.count; i++) {//选中号码
                Tag =([self.Number[i] integerValue] +1) *10001;
                UITextField *field =[self viewWithTag:Tag];
                
                number=[NSString stringWithFormat:@"bet_number%@",self.Number[i]];
                [parameters setObject:field.text forKey:number];
                
            }
            
            NSLog(@"%@",parameters);
            [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
                
            }success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSString *message =responseObject[@"message"];
                if ([message isEqualToString:@"模式新增成功！"]) {
                    self.message.text =@"模式新增成功！";
                      [self resgistData];
                } else{
                    self.message.text =message;
                }
                [self addSubview:self.AlertVc];
                [self PopMessage];
                NSLog(@"😁我的天%@",responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"❌%@",error);
            }];
            
        
        }

    }
    
    if (self.ModelID.length !=0 && ![sender.currentTitle isEqualToString:@"添加"]){
        sender.selected =!sender.selected;
        if (sender.selected) {//编辑
            self.Edit =YES;
            text.userInteractionEnabled =YES;
            for (int i=0; i<[self.countStr intValue]; i++) {
                UIButton *button =[self viewWithTag:(i+1) * 10000];
                UITextField *text =[self viewWithTag:(i+1) * 10001];
                
                [button setBackgroundImage:[UIImage imageNamed:@"placeholderNumber"] forState:UIControlStateNormal];//全部复原
                [button setTitleColor:[UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1] forState:UIControlStateNormal];
                
                button.userInteractionEnabled =YES;
                text.placeholder =@"输入金额";
                text.borderStyle =UITextBorderStyleRoundedRect;
                [button addTarget:self action:@selector(NewEdit:) forControlEvents:UIControlEventTouchUpInside];
                [button setBackgroundImage:[UIImage imageNamed:@"placeholderNumber"] forState:UIControlStateNormal];
                [button setBackgroundImage:[UIImage imageNamed:@"Number_back"] forState:UIControlStateSelected];
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
                
                text.userInteractionEnabled =NO;
                
            }
            
        }else{//保存
            
            NSInteger Tag;
            NSString *number;
            
            AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
            manager.responseSerializer.acceptableContentTypes =[manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/json"];
            
            NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
            NSString *url =[CREATEURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            
            [parameters setObject:self.Style forKey:@"game_type"];
            [parameters setObject:@"34260172" forKey:@"user_number"];
            [parameters setObject:text.text forKey:@"mode_name"];
            [parameters setObject:self.ModelID forKey:@"mode_id"];
            NSLog(@"❌%@",self.Number);
            
            for (int i = 0; i<self.Number.count; i++) {//选中号码
                Tag =([self.Number[i] integerValue] +1) *10001;
                UITextField *field =[self viewWithTag:Tag];
                
                number=[NSString stringWithFormat:@"bet_number%@",self.Number[i]];
                [parameters setObject:field.text forKey:number];
                
            }
            
            NSLog(@"%@",parameters);
            [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
                
            }success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSString *message =[NSString stringWithFormat:@"%@",responseObject[@"message"]];
                if ([message isEqualToString:@"修改成功！"]) {
                    self.message.font =[UIFont systemFontOfSize:17];
                    self.message.text =@"修改成功！";
                    
                    text.userInteractionEnabled =NO;
                    self.Edit =NO;
                    for (int i=0; i<[self.countStr intValue]; i++) {
                        UIButton *button =[self viewWithTag:(i+1) * 10000];
                        UITextField *text =[self viewWithTag:(i+1) * 10001];
                        
                        [button setTitleColor:[UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1] forState:UIControlStateNormal];
                        button.userInteractionEnabled =NO;
                        text.placeholder =@"";
                        text.borderStyle =UITextBorderStyleNone;
                        
                        text.userInteractionEnabled =NO;
                        
                    }
                    [self resgistData];
                    
                }else{
                    sender.selected =YES;
                    self.message.text =message;
                    self.message.font =[UIFont systemFontOfSize:15];
                }
                [self addSubview:self.AlertVc];
                [self PopMessage];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"❌%@",error);
            }];
            
        }
    }
    
}




- (void)PopMessage{
    [UIView animateWithDuration:2.5 // 动画时长
                          delay:0.0 // 动画延迟
         usingSpringWithDamping:1.0 // 类似弹簧振动效果 0~1
          initialSpringVelocity:5.0 // 初始速度
                        options:UIViewAnimationOptionCurveEaseInOut // 动画过渡效果
                     animations:^{
                         // code...
                         CGRect rect =CGRectMake(SCREEN_WIDTH/2 - 100, SCREEN_HEIGHT/2-35, 200, 70);
                         self.AlertVc.frame =rect;
                     } completion:^(BOOL finished) {
                         // 动画完成后执行
                         // code...
                         [self.AlertVc removeFromSuperview];
                         CGRect rect =CGRectMake(SCREEN_WIDTH/2 - 100, SCREEN_HEIGHT, 200, 70);
                         self.AlertVc.frame =rect;
                     }];

}

- (void)PopBtnMessage{
    [UIView animateWithDuration:0.7 // 动画时长
     
                     animations:^{
     CGRect rect =CGRectMake(SCREEN_WIDTH/2 - 100, SCREEN_HEIGHT/2-50, 200, 100);
     self.AlertVcBtn.frame =rect;
                         self.TableView.userInteractionEnabled =NO;
     }];

    
}





- (void)resgistData{
    self.Edit=NO;
    self.ModelEdit =77777;
    UITextField *text =[self viewWithTag:997];
    text.placeholder =@"输入模式名称";
    self.ModelID =nil;
    self.selectModelName =nil;
    self.btnStyle =nil;
    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes =[manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/json"];
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    NSString *url =[INDEXURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    [parameters setObject:self.Style forKey:@"type"];
    [parameters setObject:@"34260172" forKey:@"user_number"];
    [parameters setObject:@"1" forKey:@"page"];
    
    
    [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    }success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.ModelArray = responseObject[@"data"];
        [self.TableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"❌%@",error);
    }];
}


- (void)deleteClick:(UIButton *)sender{
    if (self.selectModelName.length!=0 && ![self.selectModelName isEqualToString:@" + "]) {
        
        [self addSubview: self.AlertVcBtn];
        self.messageBtn.text =@"是否删除该模型";
        [self PopBtnMessage];


    }
    
}




- (void)BtnYesClick:(UIButton *)sender{
    if ([sender.currentTitle isEqualToString:@"确定"]) {
        self.TableView.userInteractionEnabled =YES;
        AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
        manager.responseSerializer.acceptableContentTypes =[manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/json"];
        
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        NSString *url =[DELETEURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        
        [parameters setObject:self.Style forKey:@"type"];
        [parameters setObject:@"34260172" forKey:@"user_number"];
        [parameters setObject:self.ModelID forKey:@"mode_id"];
        

        [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
        }success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSString *message=responseObject[@"message"];
            if ([message isEqualToString:@"模式删除成功！"]) {
                [self resgistData];
            }
             self.message.text =message;
            [self addSubview:self.AlertVc];
            [self PopMessage];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
        [self.AlertVcBtn removeFromSuperview];
        
    } else {
        [self.AlertVcBtn removeFromSuperview];
        self.TableView.userInteractionEnabled =YES;

        
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
- (void)click:(UIButton *)sender{//确定退出
    [self.choose removeAllObjects];
    NSLog(@"==-=-=-=-%ld",self.selectModelName.length);
    if ([sender.currentTitle isEqualToString:@"确认"]) {
        NSInteger Tag;
       
        if (self.selectModelName.length !=0) {
            for (int i = 0; i<self.Number.count; i++) {//选中号码
                Tag =([self.Number[i] integerValue] +1) *10001;
                UITextField *field =[self viewWithTag:Tag];
                [self.choose setValue:field.text forKey:self.Number[i]];
               
                NSLog(@"%@  =  %@",field.text,self.Number[i]);
            }
            
            if (self.betDics) {
                self.betDics(self.choose,self.Number);
            }
             self.hidden =YES;
        } else{
            [self addSubview:self.AlertVc];
            self.message.text =@"请选择模式";
            [self PopMessage];
        }
      
        
    } else{
        self.hidden =YES;
    }
   
}
- (void)handleForBetType:(BlockBetNumber)block{
    
    self.betDics =block;
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
