//
//  GameCenterTableViewCell.h
//  Lucky28
//
//  Created by 九旺网络 on 2016/10/25.
//  Copyright © 2016年 Jiuwang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JWHome.h"

@interface GameCenterTableViewCell : UITableViewCell
/**左边图片*/
@property (weak, nonatomic) IBOutlet UIButton *LeftBtn;
/**右边图片*/
@property (weak, nonatomic) IBOutlet UIButton *RightBtn;
/**左边按城市名称*/
@property (weak, nonatomic) IBOutlet UILabel *LeftCityName;
/**右边城市名称*/
@property (weak, nonatomic) IBOutlet UILabel *RightCityName;
/**左边奖池*/
@property (weak, nonatomic) IBOutlet UILabel *LeftAwardMoney;
/**右边奖池*/
@property (weak, nonatomic) IBOutlet UILabel *RightAwardMoney;
/**左边期号*/
@property (weak, nonatomic) IBOutlet UILabel *LeftStage;
/**右边期号*/
@property (weak, nonatomic) IBOutlet UILabel *RightStage;
/**左边时间*/
@property (weak, nonatomic) IBOutlet UILabel *LeftTime;
/**右边时间*/
@property (weak, nonatomic) IBOutlet UILabel *RightTime;
/**左边图片*/
@property (weak, nonatomic) IBOutlet UIImageView *LeftImage;
/**右边图片*/
@property (weak, nonatomic) IBOutlet UIImageView *RightImage;
@property (nonatomic, strong) JWHome *home;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
