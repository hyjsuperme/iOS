//
//  JWBetHistoryTableViewCell.m
//  Lucky28
//
//  Created by 九旺网络 on 2016/11/16.
//  Copyright © 2016年 Jiuwang. All rights reserved.
//

#import "JWBetHistoryTableViewCell.h"



@implementation JWBetHistoryTableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID =@"ID3";
    JWBetHistoryTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell =[[[NSBundle mainBundle]loadNibNamed:@"JWBetHistoryTableViewCell" owner:nil options:nil]firstObject];
    }
    return cell;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


@end
