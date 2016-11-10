//
//  BetingBallTableViewCell.h
//  Lucky28
//
//  Created by 九旺网络 on 2016/11/8.
//  Copyright © 2016年 Jiuwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BetingBallTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *topColor;

@property (weak, nonatomic) IBOutlet UIButton *NumberBtn;
+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
