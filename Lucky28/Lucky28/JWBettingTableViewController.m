//
//  JWBetTableViewController.m
//  Lucky28
//
//  Created by 九旺网络 on 2016/10/31.
//  Copyright © 2016年 Jiuwang. All rights reserved.
//

#import "JWBetTableViewController.h"
#import "JWBettingTableViewCell.h"
#import "JWBetHeaderTableViewCell.h"
#import "JWShowHandTableViewCell.h"
#import "JWBetBottomTableViewCell.h"

@interface JWBetTableViewController ()

@end

@implementation JWBetTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        JWBetHeaderTableViewCell *cell =[JWBetHeaderTableViewCell cellWithTableView:tableView];
        return cell;
    }
    else if (indexPath.row == 1){
        JWBettingTableViewCell *cell =[JWBettingTableViewCell cellWithTableView:tableView];
        return cell;
    }
    else if (indexPath.row == 2){
        JWShowHandTableViewCell *cell =[JWShowHandTableViewCell cellWithTableView:tableView];
        return cell;
    }
    else if (indexPath.row == 3){
        JWBetBottomTableViewCell *cell =[JWBetBottomTableViewCell cellWithTableView:tableView];
        return cell;

        
    }
    
    
    
    return 0;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 67;
    }
    else if (indexPath.row == 1){
        return 450;
    }
    else if (indexPath.row == 2){
        return 127;
    } else if (indexPath.row == 3){
        return 130;
    }
    return 0;

}

@end
