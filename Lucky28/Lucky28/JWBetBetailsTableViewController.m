//
//  JWBetBetailsTableViewController.m
//  Lucky28
//
//  Created by 九旺网络 on 2016/11/18.
//  Copyright © 2016年 Jiuwang. All rights reserved.
//

#import "JWBetBetailsTableViewController.h"
#import "JWBetBetailsTableViewCell.h"
#import "JWModelDateilsTableViewCell.h"

@interface JWBetBetailsTableViewController ()

@end

@implementation JWBetBetailsTableViewController

- (NSArray *)betArray{
    if (!_betArray) {
        _betArray =[NSArray array];
    }
    return _betArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle =UITableViewCellSelectionStyleNone;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) return 1;
    if (section==1) return self.betArray.count;
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        JWBetBetailsTableViewCell *cell =[JWBetBetailsTableViewCell cellWithTableView:tableView];
        
        cell.GameType.text =self.title;//游戏类型
        NSString *code =[NSString stringWithFormat:@"%@",self.details[@"code"]];
        
        if ([code isEqualToString:@"0000"]) {
            cell.YesOrNo.image =[UIImage imageNamed:@"YesImage"];
            cell.Success.text =@"投注成功";
        }else{
            cell.YesOrNo.image =[UIImage imageNamed:@""];
            cell.Success.text =@"投注失败";
        }
        
        //   cell.OpenNumber  是否开奖
        cell.Stage.text =[NSString stringWithFormat:@"%@期",self.stage];
        cell.BetMoney.text =[NSString stringWithFormat:@"%@",self.details[@"data"][@"bet"]];
        cell.Time.text =[NSString stringWithFormat:@"%@",self.details[@"data"][@"opentime"]];
        cell.FirstNumber.text =[NSString stringWithFormat:@"%@",self.details[@"data"][@"openno"][0]];
        cell.SecondNumber.text =[NSString stringWithFormat:@"%@",self.details[@"data"][@"openno"][1]];
        cell.ThreeNumber.text =[NSString stringWithFormat:@"%@",self.details[@"data"][@"openno"][2]];
        cell.Sum.text =[NSString stringWithFormat:@"%@",self.details[@"data"][@"final"]];
        
        return cell;
    }
    if (indexPath.section == 1){
        JWModelDateilsTableViewCell *cell =[JWModelDateilsTableViewCell cellWithTableView:tableView];
        cell.Number.text =[NSString stringWithFormat:@"%@",self.details[@"data"][@"numbers"][indexPath.row][@"bet_number"]];
        cell.odd.text =[NSString stringWithFormat:@"x%@",self.details[@"data"][@"numbers"][indexPath.row][@"odd_opened"]];
        cell.Money.text =[NSString stringWithFormat:@"%@",self.details[@"data"][@"numbers"][indexPath.row][@"bet"]];
        cell.WinOrLoseMoney.text =[NSString stringWithFormat:@"%@",self.details[@"data"][@"won"]];
        return cell;
    }
    return 0;
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
         return 430;
    } else{
        return 43;
    }
   
}

@end
