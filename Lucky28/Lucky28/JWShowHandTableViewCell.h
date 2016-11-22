//
//  JWShowHandTableViewCell.h
//  Lucky28
//
//  Created by 九旺网络 on 2016/10/31.
//  Copyright © 2016年 Jiuwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JWShowHandTableViewCell : UITableViewCell
/**下注滚动条*/
@property (weak, nonatomic) IBOutlet UISlider *ShowHandSlider;
/**梭哈*/
@property (weak, nonatomic) IBOutlet UIButton *ShowHand;
/**反选*/
@property (weak, nonatomic) IBOutlet UIButton *Inverse;
/**下注金额*/
@property (weak, nonatomic) IBOutlet UILabel *SliderValue;
/**定额梭哈金额*/
@property (weak, nonatomic) IBOutlet UITextField *MoneyTextField;

+(instancetype)cellWithTableView:(UITableView *)tableView;
@end
