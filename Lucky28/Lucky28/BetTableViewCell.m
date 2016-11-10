//
//  BetTableViewCell.m
//  Lucky28
//
//  Created by 九旺网络 on 2016/10/28.
//  Copyright © 2016年 Jiuwang. All rights reserved.
//

#import "BetTableViewCell.h"

@implementation BetTableViewCell


+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID =@"ID2";
    BetTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell =[[[NSBundle mainBundle]loadNibNamed:@"BetTableViewCell" owner:nil options:nil]firstObject];
    }
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}


@end
