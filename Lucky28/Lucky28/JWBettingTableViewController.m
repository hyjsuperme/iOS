//
//  JWBetTableViewController.m
//  Lucky28
//
//  Created by 九旺网络 on 2016/10/31.
//  Copyright © 2016年 Jiuwang. All rights reserved.
//

#import "JWBettingTableViewController.h"
#import "JWBettingTableViewCell.h"
#import "JWBetHeaderTableViewCell.h"
#import "JWShowHandTableViewCell.h"
#import "JWBetBottomTableViewCell.h"
#import "JWBetDefaultPopViewController.h"
#import "BetDefaultPopView.h"
#import "JWfootView.h"
#import "BetingBallTableViewCell.h"
#import "JWMyModelPopView.h"
#import "JWBetHistroyTableViewController.h"
@interface JWBettingTableViewController ()
@property (nonatomic, strong) BetDefaultPopView *alertView;
@property (nonatomic, strong) JWMyModelPopView *MyModelAleartView;

@property (nonatomic, strong) NSMutableArray *betArray;

@property (nonatomic, strong) NSMutableArray *oddsArray;

@property (nonatomic, strong) NSMutableDictionary *MoneyDic;//默认钱
@property (nonatomic, strong) NSMutableDictionary *MoneyDic1;//默认钱


@property (nonatomic, assign) NSInteger sum;
/**总金额*/
@property (nonatomic, assign) NSInteger sumTime;

@property (nonatomic, assign) NSInteger Number;
/**倍数*/
@property (nonatomic, assign) NSInteger times;

@property (nonatomic ,assign) NSInteger ShowHansMoney;

@property (nonatomic, strong) NSMutableArray *eventBetMoney;

@property (nonatomic, strong) UIAlertController *alertVc;




@end

@implementation JWBettingTableViewController
//每一个下注金额
- (NSMutableArray *)eventBetMoney{
    if (!_eventBetMoney) {
        _eventBetMoney =[NSMutableArray array];
    }
    return _eventBetMoney;
}
- (NSMutableDictionary*)MoneyDic{
    if (!_MoneyDic) {
        _MoneyDic =[NSMutableDictionary dictionary];
    }
    return _MoneyDic;
}
- (NSMutableDictionary*)MoneyDic1{
    if (!_MoneyDic1) {
        _MoneyDic1 =[NSMutableDictionary dictionary];
    }
    return _MoneyDic1;
}

- (NSMutableArray*)oddsArray{
    if (!_oddsArray) {
        _oddsArray =[NSMutableArray array];
    }
    return _oddsArray;
}
- (NSArray *)Odds{
    if (!_Odds) {
        _Odds =[NSArray array];
    }
    return _Odds;
}

- (NSMutableArray *)betArray{
    if (!_betArray) {
        _betArray =[[NSMutableArray  alloc]init];
    }
    return _betArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =self.CityName;
    UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"投注记录" forState:UIControlStateNormal];
    [button sizeToFit];
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:button];
    [button addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    
    JWfootView *foot =[[JWfootView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 55)];
    self.tableView.tableFooterView =foot;
    [foot.clearBet addTarget:self action:@selector(clearData) forControlEvents:UIControlEventTouchUpInside];//清除按钮
    [foot.YesBet addTarget:self action:@selector(YesBtnClcik) forControlEvents:UIControlEventTouchUpInside];//确定按钮
    [foot.autoBet addTarget:self action:@selector(autoBetClcik) forControlEvents:UIControlEventTouchUpInside];//确定按钮
    
    self.tableView.showsVerticalScrollIndicator =NO;
    self.tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(Receive:) name:@"ButtonNameAdd" object:nil];//选择号码
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ReceiveRemove:) name:@"ButtonNameRemove" object:nil];//删除号码
      [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(TimesAdd:) name:@"TimesAdd" object:nil];//倍数加
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(BetMoney:) name:@"BetMoney" object:nil];//个体倍数
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ShowHandMoney:) name:@"ShowHandMoney" object:nil];//定额说梭哈

}
- (void)autoBet{
    
}
- (void)YesBtnClcik{//确认按钮
    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes =[manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/json"];
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    NSString *url =[BETINGURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString *gametype =[NSString NmuberTogameType: self.CityName];
    [parameters setObject:gametype forKey:@"type"];//游戏类型
    [parameters setObject:@"34260172" forKey:@"user_number"];//游戏期号
    [parameters setObject:self.sn forKey:@"sn"];
  
    NSString *Number;//号码
    NSString *Money;//金额
    for (int i = 0; i<self.betArray.count; i++) {
        Number = [NSString stringWithFormat:@"bet_number%@", self.betArray[i]];
        Money =[self.MoneyDic objectForKey:self.betArray[i]];
        [parameters setObject:Money forKey:Number];
    }
    
    NSLog(@"参数%@",parameters);

    [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"成功：%@",responseObject);
        NSString *string =responseObject[@"message"];
        
     self.alertVc =[UIAlertController alertControllerWithTitle:@"提示" message:string preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok =[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self hiddenView];
        }];
        [self.alertVc addAction:ok];
        [self presentViewController:self.alertVc animated:NO completion:nil];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        
    }];
    

}
- (void)hiddenView{
    [self.alertVc dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)ShowHandMoney:(NSNotification *)Noti{//定额梭哈
    
    NSDictionary *dic =Noti.userInfo;
    NSString *str =dic[@"Money"];
    if (str.length!=0 && [str integerValue]!=0) {
     //[self.MoneyDic removeAllObjects];
        self.times =0;
        NSString *money;
        for (int i = 0; i<self.betArray.count; i++) {
            money =[self.MoneyDic1 objectForKey:self.betArray[i]];
            [self.MoneyDic setObject:money forKey:self.betArray[i]];
        
        }
     //self.MoneyDic =self.MoneyDic1;
      
     self.sumTime =0;
    self.ShowHansMoney =[str integerValue];
    NSInteger betMoney;
    NSString *betMoneyStr;
        
    float showHand =(float)self.ShowHansMoney/self.sum;//倍数
    for (int i = 0; i<self.betArray.count; i++) {
        betMoney =[[self.MoneyDic objectForKey:self.betArray[i]] integerValue] *showHand;//获取选中号码对应的金额，并修改
        betMoneyStr =[NSString stringWithFormat:@"%ld",betMoney];
        [self.MoneyDic setObject:betMoneyStr forKey:self.betArray[i]];//再赋值
       self.sumTime +=[[self.MoneyDic objectForKey:self.betArray[i]] integerValue];
    }
        NSLog(@"+++%@",dic[@"Money"]);
    }
    
    [self.tableView reloadData];
    
}
- (void)BetMoney:(NSNotification *)Noti{//个体倍数
   
    self.sumTime =0;
    NSDictionary *dic =Noti.userInfo;
    [self.MoneyDic setValue:dic[@"Money"] forKey:dic[@"Number"]];
    NSLog(@"%@",self.MoneyDic);
    for (int i = 0; i<self.betArray.count; i++) {
    self.sumTime +=[[self.MoneyDic objectForKey:self.betArray[i]] integerValue];
    }
    NSLog(@"%ld",self.sumTime);
    [self.tableView reloadData];
}
- (void)TimesAdd:(NSNotification *)Noti{//修改倍数
    NSDictionary *dic =Noti.userInfo;
    NSString *str =dic[@"TimesAdd"];
    self.times =[str integerValue];

    [self.tableView reloadData];
}

-(void)clearData{//清除数据
    [self.betArray removeAllObjects];
    [self.oddsArray removeAllObjects];
    self.Number =0;
    self.sum = 0;
    self.sumTime =0;
    self.ShowHansMoney=0;
    [self.tableView reloadData];
}
- (void)rightClick{
    JWBetHistroyTableViewController *histroyTVC =[JWBetHistroyTableViewController alloc];
    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes =[manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/json"];
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    NSString *url =[USERBETLOG stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString *gametype =[NSString NmuberTogameType: self.CityName];
    [parameters setObject:gametype forKey:@"type"];//游戏类型
    [parameters setObject:@"34260172" forKey:@"user_number"];//游戏期号
    [parameters setObject:@"1" forKey:@"page"];
    
   // NSLog(@"%@ %@",gametype,mstring);
    [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"参数：%@",responseObject);
        histroyTVC.betLogArray =responseObject[@"data"];
        [self.navigationController pushViewController:histroyTVC animated:YES];
        histroyTVC.title =self.title;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        
    }];

    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 3) {
        return self.betArray.count;
    }else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 && indexPath.row ==0) {
        
        JWBetHeaderTableViewCell *cell =[JWBetHeaderTableViewCell cellWithTableView:tableView];
        [cell.DefaultBtn addTarget:self action:@selector(popView:) forControlEvents:UIControlEventTouchUpInside];
        [cell.MyView addTarget:self action:@selector(popMyView:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        return cell;
        
    }
    else if (indexPath.section == 1 && indexPath.row ==0){
        JWBettingTableViewCell *cell =[JWBettingTableViewCell cellWithTableView:tableView];
         cell.selectionStyle =UITableViewCellSelectionStyleNone;
         cell.betArray =self.betArray;
        for (int i=0; i<self.Odds.count; i++) {
            NSInteger j =121+i;
            UILabel *label =[cell viewWithTag:j];
           // NSLog(@"Tag:%ld",label.tag);
            float odd =[self.Odds[i] floatValue];
            NSLog(@"%d",i);
            label.text =[NSString stringWithFormat:@"%0.2f",odd];;
        }
        
     
        
        return cell;
    }
    else if (indexPath.section == 2 && indexPath.row ==0){
        JWShowHandTableViewCell *cell =[JWShowHandTableViewCell cellWithTableView:tableView];
         cell.selectionStyle =UITableViewCellSelectionStyleNone;
        UIImage *setLeft =[UIImage imageNamed:@"chooseSlider"];
        UIImage *setRigth =[UIImage imageNamed:@"sliderLine"];
        //滑动块图片
        UIImage *thumbImage =[UIImage imageNamed:@"sliderBall"];
         cell.ShowHandSlider.value =0.50;
         cell.ShowHandSlider.backgroundColor =[UIColor clearColor];
         cell.ShowHandSlider.value =0.5;
         cell.ShowHandSlider.minimumValue =0.0;
         cell.ShowHandSlider.maximumValue =1.0;
        [cell.ShowHandSlider setMinimumTrackImage:setLeft forState:UIControlStateNormal];
        [cell.ShowHandSlider setMaximumTrackImage:setRigth forState:UIControlStateNormal];
        //这里要加UIControlStateHighlighted的状态，不然在滑动的时候会变回原生的状态
        [cell.ShowHandSlider setThumbImage:thumbImage forState:UIControlStateHighlighted];
        [cell.ShowHandSlider setThumbImage:thumbImage forState:UIControlStateNormal];
        [cell.ShowHandSlider addTarget:self action:@selector(changeValue:) forControlEvents:UIControlEventValueChanged];
       // [cell.ShowHand addTarget:self action:@selector(showHandClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.Inverse addTarget:self action:@selector(inverseClick:) forControlEvents:UIControlEventTouchUpInside];
        cell.MoneyTextField.text =[NSString stringWithFormat:@"%ld",self.ShowHansMoney];
        cell.MoneyTextField.keyboardType =UIKeyboardTypeNumberPad;
        return cell;
    }
    
    else if (indexPath.section == 4 && indexPath.row ==0){
        JWBetBottomTableViewCell *cell =[JWBetBottomTableViewCell cellWithTableView:tableView];
        cell.times.text =[NSString stringWithFormat:@"%ld",self.times];
        cell.stage.text =@"0";
        cell.Number.text =[NSString stringWithFormat:@"共%ld注",self.Number];
        cell.Money.text =[NSString stringWithFormat:@"%ld金豆",self.sumTime *(self.times +1)];
        cell.UserMoney.text =[NSString stringWithFormat:@"%@金豆",self.userMoney];
        
        if (self.sumTime *(self.times +1) >[self.userMoney integerValue]) {
            cell.Message.text =@"金豆不足";
        } else{
            cell.Message.text =@"";
        }
         cell.selectionStyle =UITableViewCellSelectionStyleNone;
        
        return cell;
    }else if(indexPath.section == 3 ){
        
        BetingBallTableViewCell *cell =[BetingBallTableViewCell cellWithTableView:tableView];
        
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        [cell.NumberBtn setTitle:self.betArray[indexPath.row] forState:UIControlStateNormal];//选中号码
        NSString *string =self.oddsArray[indexPath.row];//赔率
        cell.Odds.text =string;//赔率
        NSString *moneyStr =[self.MoneyDic objectForKey:cell.NumberBtn.currentTitle];
        if (self.ShowHansMoney) {
            
        }
        //float ShowHMoney = (float)self.ShowHansMoney/self.sumTime;
        NSInteger money= [moneyStr integerValue] *(self.times +1);
        cell.textField.text = [NSString stringWithFormat:@"%ld",money];
        
       
        
        if (indexPath.row != 0) {
            cell.topColor.backgroundColor =JWColorA(245, 245, 245, 1);
        }else{
            cell.topColor.backgroundColor =JWColorA(197, 197, 197, 1);
        }
        return cell;
    }
    
    return 0;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (void)changeValue:(UISlider *)slider{//滑动滚动条
    UILabel *label =[self.view viewWithTag:511];
    label.text =[NSString stringWithFormat:@"(%0.2f)",slider.value];
    UIButton *button =[self.view viewWithTag:531];
    button.selected =NO;
    
    if ( (int)slider.value == 1) {
        button.selected =YES;
    }
   // [button setBackgroundImage:[UIImage imageNamed:@"BetBox"]forState:UIControlStateNormal];

    
}
//点击梭哈
//- (void)showHandClick:(UIButton *)sender{
//    sender.selected= YES;
//    
//    
//    UISlider *slider =[self.view viewWithTag:521];
//    slider.value =1.0;
//}
//点击反选
- (void)inverseClick:(UIButton *)sender{
    [self.MoneyDic removeAllObjects];
    [self.betArray removeAllObjects];
    [self.oddsArray removeAllObjects];
    for (int i =0; i<28; i++) {
        UIButton *button =[self.view viewWithTag:(i+1)*100];
        if (!button.selected) {
             NSLog(@"%@ %d",button.currentTitle, button.selected);
            [self.betArray addObject:button.currentTitle];

        }
    }
    for (int i =0 ; i <self.betArray.count; i++) {
        NSInteger Tag =[self.betArray[i] integerValue] +121;
        UILabel *label =[self.view viewWithTag:Tag];
        NSString *string =label.text;
        [self.oddsArray addObject:string];
        
    }
    NSInteger money;
    self.sum=0;
    for (int i = 0; i<self.betArray.count; i++) {
        money =1000 / [self.oddsArray[i] floatValue];
        NSString *string =[NSString stringWithFormat:@"%ld",money];
        [self.MoneyDic setObject:string forKey:self.betArray[i]];
        [self.MoneyDic1 setObject:string forKey:self.betArray[i]];
       
        self.sum+=money; //总金额
        
    }
    
    self.sumTime =self.sum;
    self.times =0;
    self.Number =self.betArray.count;//注数
    
    [self.tableView reloadData];
    
}
- (void)Receive:(NSNotification *)Noti{//单独点击添加
    //[self.MoneyDic removeAllObjects];
    [self.oddsArray removeAllObjects];
    NSDictionary *dic =Noti.userInfo;
    NSString *str =dic[@"ButtonName"];
    [self.betArray addObject:str];
    for (int i =0 ; i <self.betArray.count; i++) {
        NSInteger Tag =[self.betArray[i] integerValue] +121;
        UILabel *label =[self.view viewWithTag:Tag];
       // NSString *string =[label.text substringFromIndex:3];
          NSString *string =label.text;
         // NSLog(@"i=%d text =%@",i,string);
        [self.oddsArray addObject:string];
    }
    NSLog(@"选中号码%@",self.betArray);
    NSLog(@"赔率%@",self.oddsArray);
    NSInteger money;
    NSInteger number =[str integerValue];
    UILabel *label =[self.view viewWithTag:(number +121)];
    money =1000 / [label.text floatValue];
    NSString *string =[NSString stringWithFormat:@"%ld",money];
    [self.MoneyDic setObject:string forKey:str];
     [self.MoneyDic1 setObject:string forKey:str];
    NSLog(@"%@+++",self.MoneyDic1);
    self.sum=0;
    for (int i = 0; i<self.betArray.count; i++) {
     
        money =[[self.MoneyDic1 objectForKey:self.betArray[i]] integerValue];
        self.sum+=money; //总金额
        
    }
    
    self.sumTime =self.sum;
    self.times =0;
    self.Number =self.betArray.count;//注数
    //self.MoneyDic1 =self.MoneyDic;
    NSLog(@"字典%@ sum %ld",self.MoneyDic ,self.sum);
    
    [self.tableView reloadData];
    
    
    

    
}
- (void)ReceiveRemove:(NSNotification *)Noti{//单独点击取消
  //  [self.MoneyDic removeAllObjects];
    [self.oddsArray removeAllObjects];
    NSDictionary *dic =Noti.userInfo;
    [self.betArray removeObject:dic[@"ButtonName"]];
    for (int i =0 ; i <self.betArray.count; i++) {
       
        NSInteger Tag =[self.betArray[i] integerValue] +121;
        UILabel *label =[self.view viewWithTag:Tag];
    
          NSString *string =label.text;
        [self.oddsArray addObject:string];
    }
    
    [self.MoneyDic removeObjectForKey:dic[@"ButtonName"]];//移除金额
     [self.MoneyDic1 removeObjectForKey:dic[@"ButtonName"]];
    NSInteger money;
    self.sum=0;
    for (int i = 0; i<self.betArray.count; i++) {
        
        money =[[self.MoneyDic1 objectForKey:self.betArray[i]] integerValue];
        self.sum+=money; //总金额
        
    }
    self.sumTime =self.sum;
    self.times =0;
    self.Number =self.betArray.count;//注数
//    self.MoneyDic1 =self.MoneyDic;
    NSLog(@"字典%@ sum %ld",self.MoneyDic ,self.sum);
    
     [self.tableView reloadData];
}
//默认样式
- (void)popView:(UIButton *)sender{
    
   
    self.alertView =[[BetDefaultPopView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.alertView handleForBetType:^(NSMutableArray *BetArray, NSInteger BetName) {
         NSLog(@"111111");
        [self.betArray removeAllObjects];
        [self.oddsArray removeAllObjects];
        [self.MoneyDic removeAllObjects];
        for (int i =0 ; i <BetArray.count; i++) {
            [self.betArray addObject:BetArray[i]];
            NSInteger Tag =[self.betArray[i] integerValue] +121;
            UILabel *label =[self.view viewWithTag:Tag];
           // NSString *string =[label.text substringFromIndex:3];
              NSString *string =label.text;
            [self.oddsArray addObject:string];
        }
        NSInteger money;
        self.sum=0;
        for (int i = 0; i<self.betArray.count; i++) {
            money =1000 / [self.oddsArray[i] floatValue];
            NSString *string =[NSString stringWithFormat:@"%ld",money];
            [self.MoneyDic setObject:string forKey:self.betArray[i]];
             [self.MoneyDic1 setObject:string forKey:self.betArray[i]];
            self.sum+=money; //总金额
            
        }
        self.sumTime =self.sum;
        self.times =0;
        self.Number =self.betArray.count;//注数
       // self.MoneyDic1 =self.MoneyDic;
        self.alertView.betName =BetName;
         NSLog(@"******%@",self.betArray);
        [self.tableView reloadData];
        
    }];
    [self.alertView.ChooseBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.alertView show];
    
}
//自定义样式
- (void)popMyView:(UIButton *)sender{
    self.MyModelAleartView =[[JWMyModelPopView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    NSString *str =[NSString NmuberTogameType:self.title];
    NSNotificationCenter *center =[NSNotificationCenter defaultCenter];
    [center postNotificationName:@"ModelPop" object:self userInfo:@{@"ModelPop":str}];
    [self.MyModelAleartView show];
    
    
}
//弹窗消失
- (void)click:(UIButton *)sender{
    self.alertView.hidden =YES;
    self.alertView =nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 67;
    }
    
    else if (indexPath.section == 1){
        return 450;
    }
    else if (indexPath.section == 3){
        return 44;
    }
    else if (indexPath.section == 2){
        return 127;
    } else if (indexPath.section == 4){
        return 130;
    }
    return 0;
}

@end
