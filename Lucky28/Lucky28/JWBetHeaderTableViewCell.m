//
//  JWBetHeaderTableViewCell.m
//  Lucky28
//
//  Created by 九旺网络 on 2016/10/31.
//  Copyright © 2016年 Jiuwang. All rights reserved.
//

#import "JWBetHeaderTableViewCell.h"

@implementation JWBetHeaderTableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID =@"ID";
    JWBetHeaderTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell =[[[NSBundle mainBundle]loadNibNamed:@"JWBetHeaderTableViewCell" owner:nil options:nil]firstObject];
    }
    return cell;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
