//
//  JWShowHandTableViewCell.m
//  Lucky28
//
//  Created by 九旺网络 on 2016/10/31.
//  Copyright © 2016年 Jiuwang. All rights reserved.
//

#import "JWShowHandTableViewCell.h"

@implementation JWShowHandTableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID =@"ID";
    JWShowHandTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell =[[[NSBundle mainBundle]loadNibNamed:@"JWShowHandTableViewCell" owner:nil options:nil]firstObject];
    }
    return cell;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


@end
