//
//  BetingBallTableViewCell.m
//  Lucky28
//
//  Created by 九旺网络 on 2016/11/8.
//  Copyright © 2016年 Jiuwang. All rights reserved.
//

#import "BetingBallTableViewCell.h"

@implementation BetingBallTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID =@"ID2";
    BetingBallTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell =[[[NSBundle mainBundle]loadNibNamed:@"BetingBallTableViewCell" owner:nil options:nil]firstObject];
    }
    return cell;
}


@end
