//
//  JWTableViewCell.m
//  Lucky28
//
//  Created by 九旺网络 on 2016/10/28.
//  Copyright © 2016年 Jiuwang. All rights reserved.
//

#import "JWTableViewCell.h"

@implementation JWTableViewCell


+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID =@"ID";
    JWTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell =[[[NSBundle mainBundle]loadNibNamed:@"JWTableViewCell" owner:nil options:nil]firstObject];
    }
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


@end
