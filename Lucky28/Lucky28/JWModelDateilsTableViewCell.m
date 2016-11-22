//
//  JWModelDateilsTableViewCell.m
//  Lucky28
//
//  Created by 九旺网络 on 2016/11/21.
//  Copyright © 2016年 Jiuwang. All rights reserved.
//

#import "JWModelDateilsTableViewCell.h"

@implementation JWModelDateilsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID =@"ID3";
    JWModelDateilsTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell =[[[NSBundle mainBundle]loadNibNamed:@"JWModelDateilsTableViewCell" owner:nil options:nil]firstObject];
    }
    return cell;
    
}
@end
