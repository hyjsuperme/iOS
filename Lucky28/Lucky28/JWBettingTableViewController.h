//
//  JWBetTableViewController.h
//  Lucky28
//
//  Created by 九旺网络 on 2016/10/31.
//  Copyright © 2016年 Jiuwang. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface JWBettingTableViewController : UITableViewController
/**游戏类型*/
@property (nonatomic, strong) NSString *CityName;
/**游戏类型*/
@property (nonatomic, strong) NSArray *Odds;
/**游戏期号*/
@property (nonatomic, strong) NSString *sn;
/**用户金额*/
@property (nonatomic, strong) NSString *userMoney;
@end
