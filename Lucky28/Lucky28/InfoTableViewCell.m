//
//  InfoTableViewCell.m
//  Lucky28
//
//  Created by 九旺网络 on 2016/10/25.
//  Copyright © 2016年 Jiuwang. All rights reserved.
//

#import "InfoTableViewCell.h"

@implementation InfoTableViewCell


+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID =@"ID2";
    InfoTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell =[[[NSBundle mainBundle]loadNibNamed:@"InfoTableViewCell" owner:nil options:nil]firstObject];
    }
    return cell;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


@end
