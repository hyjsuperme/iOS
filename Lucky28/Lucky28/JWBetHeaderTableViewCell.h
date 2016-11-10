//
//  JWBetHeaderTableViewCell.h
//  Lucky28
//
//  Created by 九旺网络 on 2016/10/31.
//  Copyright © 2016年 Jiuwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JWBetHeaderTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *DefaultBtn;
@property (weak, nonatomic) IBOutlet UIButton *MyView;
+(instancetype)cellWithTableView:(UITableView *)tableView;
@end
