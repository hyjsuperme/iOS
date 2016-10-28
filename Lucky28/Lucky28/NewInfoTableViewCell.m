//
//  NewInfoTableViewCell.m
//  Lucky28
//
//  Created by 九旺网络 on 2016/10/25.
//  Copyright © 2016年 Jiuwang. All rights reserved.
//

#import "NewInfoTableViewCell.h"

@implementation NewInfoTableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID =@"ID3";
    NewInfoTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell =[[[NSBundle mainBundle]loadNibNamed:@"NewInfoTableViewCell" owner:nil options:nil]firstObject];
    }
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



@end
