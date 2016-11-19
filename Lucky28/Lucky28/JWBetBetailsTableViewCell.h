//
//  JWBetBetailsTableViewCell.h
//  Lucky28
//
//  Created by 九旺网络 on 2016/11/19.
//  Copyright © 2016年 Jiuwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JWBetBetailsTableViewCell : UITableViewCell
/**游戏类型*/
@property (weak, nonatomic) IBOutlet UILabel *GameType;
/**投注是否成功图片*/
@property (weak, nonatomic) IBOutlet UIImageView *YesOrNo;
/**投注是否成功*/
@property (weak, nonatomic) IBOutlet UILabel *Success;
/**是否开奖*/
@property (weak, nonatomic) IBOutlet UILabel *OpenNumber;
/**奖金*/
@property (weak, nonatomic) IBOutlet UILabel *Money;
/**期号*/
@property (weak, nonatomic) IBOutlet UILabel *Stage;
/**模式*/
@property (weak, nonatomic) IBOutlet UILabel *Model;
/**投注金额*/
@property (weak, nonatomic) IBOutlet UILabel *BetMoney;
/**个人奖金*/
@property (weak, nonatomic) IBOutlet UILabel *UserMoney;
/**投注时间*/
@property (weak, nonatomic) IBOutlet UILabel *Time;
/**号码1*/
@property (weak, nonatomic) IBOutlet UILabel *FirstNumber;
/**号码2*/
@property (weak, nonatomic) IBOutlet UILabel *SecondNumber;
/**号码3*/
@property (weak, nonatomic) IBOutlet UILabel *ThreeNumber;
/**和*/
@property (weak, nonatomic) IBOutlet UILabel *Sum;


+(instancetype)cellWithTableView:(UITableView *)tableView;
@end
