//
//  InfoTableViewCell.h
//  Lucky28
//
//  Created by 九旺网络 on 2016/10/25.
//  Copyright © 2016年 Jiuwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *GameType;
@property (weak, nonatomic) IBOutlet UILabel *Time;
@property (weak, nonatomic) IBOutlet UILabel *stage;
@property (weak, nonatomic) IBOutlet UILabel *firstNumber;
@property (weak, nonatomic) IBOutlet UILabel *secondNumber;
@property (weak, nonatomic) IBOutlet UILabel *ThreeNumber;
@property (weak, nonatomic) IBOutlet UILabel *sumNumber;
/**第二个加号*/
@property (weak, nonatomic) IBOutlet UILabel *changeAdd;
/**第四个背景图片*/
@property (weak, nonatomic) IBOutlet UIImageView *threeBg;
/**等号*/
@property (weak, nonatomic) IBOutlet UILabel *Sum;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
