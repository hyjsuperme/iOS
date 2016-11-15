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

@interface JWBettingTableViewController ()
@property (nonatomic, strong) BetDefaultPopView *alertView;
@property (nonatomic, strong) JWMyModelPopView *MyModelAleartView;

@property (nonatomic, strong) NSMutableArray *betArray;

@end

@implementation JWBettingTableViewController



- (NSMutableArray *)betArray{
    if (!_betArray) {
        _betArray =[[NSMutableArray  alloc]init];
    }
    return _betArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =self.CityName;
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithTitle:@"投注记录" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    JWfootView *foot =[[JWfootView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 55)];
    self.tableView.tableFooterView =foot;
    self.tableView.showsVerticalScrollIndicator =NO;
    self.tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(Receive:) name:@"ButtonNameAdd" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ReceiveRemove:) name:@"ButtonNameRemove" object:nil];
  
   
    
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
        
         cell.selectionStyle =UITableViewCellSelectionStyleNone;
        return cell;
    }else if(indexPath.section == 3 ){
        
        BetingBallTableViewCell *cell =[BetingBallTableViewCell cellWithTableView:tableView];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        [cell.NumberBtn setTitle:self.betArray[indexPath.row] forState:UIControlStateNormal];
        if (indexPath.row != 0) {
            cell.topColor.backgroundColor =JWColorA(245, 245, 245, 1);
        }
        return cell;
    }
    
    return 0;
}
- (void)changeValue:(UISlider *)slider{
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
    for (int i =0; i<28; i++) {
        UIButton *button =[self.view viewWithTag:(i+1)*100];
        if (!button.selected) {

             NSLog(@"%@ %d",button.currentTitle, button.selected);
            [self.betArray addObject:button.currentTitle];

        }
    }
    [self.tableView reloadData];
    
}
- (void)Receive:(NSNotification *)Noti{
    NSDictionary *dic =Noti.userInfo;
    NSString *str =dic[@"ButtonName"];
    [self.betArray addObject:str];
   
    NSLog(@"+++++%@",self.betArray);
    [self.tableView reloadData];

    
}
- (void)ReceiveRemove:(NSNotification *)Noti{
    NSDictionary *dic =Noti.userInfo;
    [self.betArray removeObject:dic[@"ButtonName"]];
    NSLog(@"-----%@",self.betArray);
    
     [self.tableView reloadData];
}
//默认样式
- (void)popView:(UIButton *)sender{
    
   
    self.alertView =[[BetDefaultPopView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.alertView handleForBetType:^(NSMutableArray *BetArray, NSInteger BetName) {
         NSLog(@"111111");
        [self.betArray removeAllObjects];
        for (int i =0 ; i <BetArray.count; i++) {
            [self.betArray addObject:BetArray[i]];
        }
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
