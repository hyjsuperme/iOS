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

@property (nonatomic, strong) NSMutableDictionary *MoneyDic;


@property (nonatomic, assign) NSInteger sum;
/**总金额*/
@property (nonatomic, assign) NSInteger sumTime;

@property (nonatomic, assign) NSInteger Number;
/**倍数*/
@property (nonatomic, assign) NSInteger times;







@end

@implementation JWBettingTableViewController
- (NSMutableDictionary*)MoneyDic{
    if (!_MoneyDic) {
        _MoneyDic =[NSMutableDictionary dictionary];
    }
    return _MoneyDic;
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
    [foot.clearBet addTarget:self action:@selector(clearData) forControlEvents:UIControlEventTouchUpInside];
    self.tableView.showsVerticalScrollIndicator =NO;
    self.tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(Receive:) name:@"ButtonNameAdd" object:nil];//选择号码
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ReceiveRemove:) name:@"ButtonNameRemove" object:nil];//删除号码
      [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(TimesAdd:) name:@"TimesAdd" object:nil];//倍数加
    // [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(TimesCut:) name:@"TimesAdd" object:nil];//倍数加
    
    
   
    
}
- (void)TimesAdd:(NSNotification *)Noti{
    NSDictionary *dic =Noti.userInfo;
    NSString *str =dic[@"TimesAdd"];
    NSLog(@"%@",str);
    self.times =[str integerValue];
    self.sumTime =self.sum *(self.times +1);
 
   
    
    [self.tableView reloadData];
}

-(void)clearData{//清除数据
    [self.betArray removeAllObjects];
    [self.oddsArray removeAllObjects];
    self.Number =0;
    self.sum = 0;
    self.sumTime =0;
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
    [parameters setObject:@"25474305" forKey:@"user_number"];//游戏期号
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
            label.text =[NSString stringWithFormat:@"%0.2f",odd];;
        }
        
       // NSLog(@"+++++%@",self.Odds);
        
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
        [cell.ShowHand addTarget:self action:@selector(showHandClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.Inverse addTarget:self action:@selector(inverseClick:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }
    else if (indexPath.section == 4 && indexPath.row ==0){
        JWBetBottomTableViewCell *cell =[JWBetBottomTableViewCell cellWithTableView:tableView];
        cell.times.text =[NSString stringWithFormat:@"%ld",self.times];
        cell.stage.text =@"0";
        cell.Number.text =[NSString stringWithFormat:@"共%ld注",self.Number];
        cell.Money.text =[NSString stringWithFormat:@"%ld",self.sumTime];
        
         cell.selectionStyle =UITableViewCellSelectionStyleNone;
        
        return cell;
    }else if(indexPath.section == 3 ){
        
        BetingBallTableViewCell *cell =[BetingBallTableViewCell cellWithTableView:tableView];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        [cell.NumberBtn setTitle:self.betArray[indexPath.row] forState:UIControlStateNormal];//选中号码
        NSString *string =self.oddsArray[indexPath.row];//赔率
        
        cell.Odds.text =string;
       
       // NSString *string =[cell.Odds.text substringFromIndex:3];
        
        float money =[cell.Odds.text floatValue];
        cell.textField.text = [NSString stringWithFormat:@"%ld",(NSInteger)(1000 /money) *(self.times +1)];
         NSLog(@"-=-=-=-=-%@",cell.textField.text);
        
        cell.textField.tag =(indexPath.row+1)*71;
        
        
        
        if (indexPath.row != 0) {
            cell.topColor.backgroundColor =JWColorA(245, 245, 245, 1);
        }else{
            cell.topColor.backgroundColor =JWColorA(197, 197, 197, 1);
        }
        return cell;
    }
    
    return 0;
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
- (void)showHandClick:(UIButton *)sender{
    sender.selected= YES;
    UISlider *slider =[self.view viewWithTag:521];
    slider.value =1.0;
}
//点击反选
- (void)inverseClick:(UIButton *)sender{
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
        self.sum+=money; //总金额
        
    }
    self.sumTime =self.sum;
    self.times =0;
    self.Number =self.betArray.count;//注数
    
    [self.tableView reloadData];
    
}
- (void)Receive:(NSNotification *)Noti{//单独点击添加
    [self.oddsArray removeAllObjects];
    NSDictionary *dic =Noti.userInfo;
    NSString *str =dic[@"ButtonName"];
    [self.betArray addObject:str];
    for (int i =0 ; i <self.betArray.count; i++) {
        NSInteger Tag =[self.betArray[i] integerValue] +121;
        UILabel *label =[self.view viewWithTag:Tag];
       // NSString *string =[label.text substringFromIndex:3];
          NSString *string =label.text;
          NSLog(@"i=%d text =%@",i,string);
        [self.oddsArray addObject:string];
    }
    NSLog(@"选中号码%@",self.betArray);
    NSLog(@"赔率%@",self.oddsArray);
    
    
    
    NSInteger money;
    self.sum=0;
    for (int i = 0; i<self.betArray.count; i++) {
        money =1000 / [self.oddsArray[i] floatValue];
        NSString *string =[NSString stringWithFormat:@"%ld",money];
        [self.MoneyDic setObject:string forKey:self.betArray[i]];
        self.sum+=money; //总金额

    }
        self.sumTime =self.sum;
    self.times =0;
    self.Number =self.betArray.count;//注数
    NSLog(@"字典%@ sum %ld",self.MoneyDic ,self.sum);
    
    [self.tableView reloadData];
    
    
    

    
}
- (void)ReceiveRemove:(NSNotification *)Noti{//单独点击取消
    [self.oddsArray removeAllObjects];
    NSDictionary *dic =Noti.userInfo;
    [self.betArray removeObject:dic[@"ButtonName"]];
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
        self.sum+=money; //总金额
        
    }
    self.sumTime =self.sum;
    self.times =0;
    self.Number =self.betArray.count;//注数
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
            self.sum+=money; //总金额
            
        }
        self.sumTime =self.sum;
        self.times =0;
        self.Number =self.betArray.count;//注数
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
