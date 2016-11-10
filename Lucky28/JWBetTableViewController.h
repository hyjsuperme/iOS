//
//  JWBetTableViewController.h
//  Lucky28
//
//  Created by 九旺网络 on 2016/10/28.
//  Copyright © 2016年 Jiuwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JWBetTableViewController : UITableViewController
/**游戏名称*/
@property (nonatomic, strong) NSString *cityName;
/**历史记录*/
@property (nonatomic, strong) NSArray *historyData;
/**正在开奖记录*/
@property (nonatomic, strong) NSArray *LoadData;


@end
