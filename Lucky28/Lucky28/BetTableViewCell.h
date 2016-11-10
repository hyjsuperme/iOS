//
//  BetTableViewCell.h
//  Lucky28
//
//  Created by 九旺网络 on 2016/10/28.
//  Copyright © 2016年 Jiuwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BetTableViewCell : UITableViewCell
/**第一个时间*/
@property (weak, nonatomic) IBOutlet UILabel *FirstNumbar;
/**第二个数*/
@property (weak, nonatomic) IBOutlet UILabel *SecondNumber;
/**第三个数*/
@property (weak, nonatomic) IBOutlet UILabel *ThreeNumber;
/**三数之合*/
@property (weak, nonatomic) IBOutlet UILabel *sumNumber;
/**下注按钮*/
@property (weak, nonatomic) IBOutlet UIButton *BetButton;
/**期号*/
@property (weak, nonatomic) IBOutlet UILabel *Stage;
/**时间*/
@property (weak, nonatomic) IBOutlet UILabel *Time;
/**两个数的和*/
@property (weak, nonatomic) IBOutlet UILabel *sum2;
/**两个数的等号*/
@property (weak, nonatomic) IBOutlet UILabel *sumSymbol1;
/**三个数的等号*/
@property (weak, nonatomic) IBOutlet UILabel *sumSymbol2;
/**三个数和的背景*/
@property (weak, nonatomic) IBOutlet UIImageView *sumBg2;
/**两个数和的背景*/
@property (weak, nonatomic) IBOutlet UIImageView *sumBg1;
/**第三个数的背景*/
@property (weak, nonatomic) IBOutlet UIImageView *SumBg3;
@property (weak, nonatomic) IBOutlet UIImageView *firstBg1;
@property (weak, nonatomic) IBOutlet UIImageView *secondBg2;


+(instancetype)cellWithTableView:(UITableView *)tableView;
@end
