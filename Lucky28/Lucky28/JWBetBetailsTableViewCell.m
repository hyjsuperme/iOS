//
//  JWBetBetailsTableViewCell.m
//  Lucky28
//
//  Created by 九旺网络 on 2016/11/19.
//  Copyright © 2016年 Jiuwang. All rights reserved.
//

#import "JWBetBetailsTableViewCell.h"

@implementation JWBetBetailsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID =@"ID3";
    JWBetBetailsTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell =[[[NSBundle mainBundle]loadNibNamed:@"JWBetBetailsTableViewCell" owner:nil options:nil]firstObject];
    }
    return cell;
    
}

@end
