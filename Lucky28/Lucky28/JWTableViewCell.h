//
//  JWTableViewCell.h
//  Lucky28
//
//  Created by 九旺网络 on 2016/10/28.
//  Copyright © 2016年 Jiuwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JWTableViewCell : UITableViewCell
/**最新开奖期号*/
@property (weak, nonatomic) IBOutlet UILabel *TopStage;
/**最新开奖期号*/
@property (weak, nonatomic) IBOutlet UILabel *TopTime;
/**正在开奖期号*/
@property (weak, nonatomic) IBOutlet UILabel *EndStage;
/**第一个号码*/
@property (weak, nonatomic) IBOutlet UILabel *FirstNumber;
/**第二个号码*/
@property (weak, nonatomic) IBOutlet UILabel *SecondNumber;
/**第三个号码*/
@property (weak, nonatomic) IBOutlet UILabel *ThreeNumber;
/**和号码*/
@property (weak, nonatomic) IBOutlet UILabel *SumNumber;
/**时间1*/
@property (weak, nonatomic) IBOutlet UILabel *Time1;
/**时间2*/
@property (weak, nonatomic) IBOutlet UILabel *Time2;
/**时间3*/
@property (weak, nonatomic) IBOutlet UILabel *time3;
/**时间4*/
@property (weak, nonatomic) IBOutlet UILabel *Time4;
/**第一个加号*/
@property (weak, nonatomic) IBOutlet UILabel *firstAddSymbol;
/**第二个加号*/
@property (weak, nonatomic) IBOutlet UILabel *secondAddSymbol;
/**两个数之和背景*/
@property (weak, nonatomic) IBOutlet UIImageView *DoubleSumBg;
/**三个数之背景*/
@property (weak, nonatomic) IBOutlet UIImageView *ThreeSumBg;
/**第三数背景*/
@property (weak, nonatomic) IBOutlet UIImageView *ThreeNumberBg;
/**两个数的和*/
@property (weak, nonatomic) IBOutlet UILabel *DoubleSum;


+(instancetype)cellWithTableView:(UITableView *)tableView;
@end
