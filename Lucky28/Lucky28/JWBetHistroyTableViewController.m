//
//  JWBetHistroyTableViewController.m
//  Lucky28
//
//  Created by 九旺网络 on 2016/11/16.
//  Copyright © 2016年 Jiuwang. All rights reserved.
//

#import "JWBetHistroyTableViewController.h"
#import "JWBetHistoryTableViewCell.h"
#import "JWBetBetailsTableViewController.h"

@interface JWBetHistroyTableViewController ()

@property (nonatomic, strong) NSString *stage;
@property (nonatomic ,strong) UIView *heardView;
@end

@implementation JWBetHistroyTableViewController
/**投注历史*/
- (NSMutableArray *)betLogArray{
    if (!_betLogArray) {
        _betLogArray =[NSMutableArray array];
    }
    return _betLogArray;
}
- (UIView *)heardView{
    if (!_heardView) {
        _heardView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        _heardView.backgroundColor =[UIColor whiteColor];
        UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH *0.3, 10, SCREEN_WIDTH *0.4, 30)];
        label.centerX =_heardView.centerX;
        label.centerY =_heardView.centerY;
        label.text =@"第794107期 - 第794107期";
        label.textAlignment =NSTextAlignmentCenter;
        label.font =[UIFont systemFontOfSize:12];
        label.textColor =[UIColor blackColor];
        UIButton *left =[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH *0.1, 10, 30, 30)];
        [left setTitle:@"<" forState:UIControlStateNormal];
        [left setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        UIButton *right =[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH *0.8, 10, 30, 30)];
        [right setTitle:@">" forState:UIControlStateNormal];
        [right setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        left.titleLabel.font =[UIFont systemFontOfSize:25];
         right.titleLabel.font =[UIFont systemFontOfSize:25];
        [left addTarget:self action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];
         [right addTarget:self action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];
        [_heardView addSubview:left];
        [_heardView addSubview:right];
        [_heardView addSubview:label];
    }
    return _heardView;
}

- (void)Click:(UIButton *)sender{
    NSLog(@"%@",sender.currentTitle);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableHeaderView =self.heardView;
    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
   }


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.betLogArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    
    JWBetHistoryTableViewCell *cell =[JWBetHistoryTableViewCell cellWithTableView:tableView];
    NSArray *array =self.betLogArray[indexPath.row][@"open"];
    cell.Stage.text =[NSString stringWithFormat:@"第%@期",self.betLogArray[indexPath.row][@"sn"]];
   
    cell.time.text =[NSString stringWithFormat:@"开奖时间%@",self.betLogArray[indexPath.row][@"time"]];
    NSString *string =[NSString stringWithFormat:@"%@",self.betLogArray[indexPath.row][@"bet_status"]];
    NSInteger win =[string integerValue];
    if (win == 1) {
        cell.WinOrLose.image =[UIImage imageNamed:@"Open"];
    }else{
         cell.WinOrLose.image =[UIImage imageNamed:@"NoOpen"];
    }
    
    cell.FirstNumber.text =[NSString stringWithFormat:@"%@",self.betLogArray[indexPath.row][@"open"][0]];//第一个数
    cell.SecondNumber.text =[NSString stringWithFormat:@"%@",self.betLogArray[indexPath.row][@"open"][1]];//第二个数
    if (array.count == 3) {
        cell.ThreeNumber.text=[NSString stringWithFormat:@"%@",self.betLogArray[indexPath.row][@"open"][2]];
        cell.SumNumber.text =[NSString stringWithFormat:@"%@",self.betLogArray[indexPath.row][@"final"]];
        cell.PlusSign.text =@"";
        cell.TwoNmuberSum.text=@"";
        cell.TwoNumberSumBg.image =[UIImage imageNamed:@""];
    }else{
        cell.ThreeNumber.text=@"";
        cell.ThreeNumberBg.image =[UIImage imageNamed:@""];
        cell.PlusSignThree.text=@"";
        cell.SumNumber.text=@"";
        cell.ThreeNuberSumBg.image =[UIImage imageNamed:@""];
        cell.PlusSign.text=@"=";
        cell.TwoNmuberSum.text =[NSString stringWithFormat:@"%@",self.betLogArray[indexPath.row][@"final"]];
        cell.TwoNumberSumBg.image =[UIImage imageNamed:@"YellowBall"];
        
    }
  
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 74;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewCell *cell =[tableView cellForRowAtIndexPath:indexPath];
     self.stage =self.betLogArray[indexPath.row][@"sn"];
    
    JWBetBetailsTableViewController *VC =[[JWBetBetailsTableViewController alloc]init];
    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes =[manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/json"];
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    NSString *url =[USERLOG stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
   NSString *gametype =[NSString NmuberTogameType: self.title];
    [parameters setObject:gametype forKey:@"type"];//游戏类型
    [parameters setObject:@"34260172" forKey:@"user_number"];//用户ID
    [parameters setObject:self.stage forKey:@"sn"];//游戏期号
    
     NSLog(@"%@ %@",gametype,self.stage);
    [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"参数：%@",responseObject);
        
        VC.details =responseObject;
        VC.stage =self.stage;
        VC.betArray =responseObject[@"data"][@"numbers"];
        VC.title =self.title;
        [self.navigationController pushViewController:VC animated:YES];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        
    }];
    
}

@end
