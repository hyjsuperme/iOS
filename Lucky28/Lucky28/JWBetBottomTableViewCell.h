//
//  JWBetBottomTableViewCell.h
//  Lucky28
//
//  Created by 九旺网络 on 2016/10/31.
//  Copyright © 2016年 Jiuwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JWBetBottomTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *times;
@property (weak, nonatomic) IBOutlet UITextField *stage;
@property (weak, nonatomic) IBOutlet UILabel *Number;
@property (weak, nonatomic) IBOutlet UILabel *Money;
@property (weak, nonatomic) IBOutlet UILabel *UserMoney;
@property (weak, nonatomic) IBOutlet UILabel *Message;
+(instancetype)cellWithTableView:(UITableView *)tableView;
@end
