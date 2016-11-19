//
//  JWBetHistoryTableViewCell.h
//  Lucky28
//
//  Created by 九旺网络 on 2016/11/16.
//  Copyright © 2016年 Jiuwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JWBetHistoryTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *FirstNumber;
@property (weak, nonatomic) IBOutlet UILabel *SecondNumber;
@property (weak, nonatomic) IBOutlet UILabel *ThreeNumber;
@property (weak, nonatomic) IBOutlet UILabel *SumNumber;
@property (weak, nonatomic) IBOutlet UILabel *Stage;
@property (weak, nonatomic) IBOutlet UILabel *time;

@property (weak, nonatomic) IBOutlet UIImageView *WinOrLose;
@property (weak, nonatomic) IBOutlet UILabel *PlusSign;
/**第三个号的背景*/
@property (weak, nonatomic) IBOutlet UIImageView *ThreeNumberBg;
/**两个数的和*/
@property (weak, nonatomic) IBOutlet UILabel *TwoNmuberSum;
/**两个数和的背景*/
@property (weak, nonatomic) IBOutlet UIImageView *TwoNumberSumBg;
/**三个数的加号*/
@property (weak, nonatomic) IBOutlet UILabel *PlusSignThree;
/**三个数之和的背景*/
@property (weak, nonatomic) IBOutlet UIImageView *ThreeNuberSumBg;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
