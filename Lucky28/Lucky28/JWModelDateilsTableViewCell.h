//
//  JWModelDateilsTableViewCell.h
//  Lucky28
//
//  Created by 九旺网络 on 2016/11/21.
//  Copyright © 2016年 Jiuwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JWModelDateilsTableViewCell : UITableViewCell
/**模式*/
@property (weak, nonatomic) IBOutlet UILabel *Model;
/**赔率*/
@property (weak, nonatomic) IBOutlet UILabel *odd;
/**下注金额*/
@property (weak, nonatomic) IBOutlet UILabel *Money;
/**倍数*/
@property (weak, nonatomic) IBOutlet UILabel *Times;
/**输赢金额*/
@property (weak, nonatomic) IBOutlet UILabel *WinOrLoseMoney;
/**投注号码*/
@property (weak, nonatomic) IBOutlet UILabel *Number;
+(instancetype)cellWithTableView:(UITableView *)tableView;
@end
