//
//  GameCenterTableViewCell.m
//  Lucky28
//
//  Created by 九旺网络 on 2016/10/25.
//  Copyright © 2016年 Jiuwang. All rights reserved.
//

#import "GameCenterTableViewCell.h"

@interface GameCenterTableViewCell ()
/*城市图片*/
@property (nonatomic, strong) NSArray *cityImageArray;
//@property (nonatomic, assign) NSInteger time;
@end

@implementation GameCenterTableViewCell
- (NSArray *)cityImageArray{
    if (!_cityImageArray) {
        _cityImageArray =[NSArray arrayWithObjects:@"CityGame1",@"CityGame2",@"CityGame3",@"CityGame4",@"CityGam5",@"CityGame6",@"CityGame7",@"CityGame8",@"CityGame9", nil];
    }
    return _cityImageArray;
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID =@"ID1";
    GameCenterTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell =[[[NSBundle mainBundle]loadNibNamed:@"GameCenterTableViewCell" owner:nil options:nil]firstObject];
    }
    return cell;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    for (int i=0; i < 9; i++) {
        if (i%2 == 0) {
            self.LeftImage.image =[UIImage imageNamed:self.cityImageArray[i]];
        } else{
            self.RightImage.image =[UIImage imageNamed:self.cityImageArray[i]];
        }
        
    }
   
}


@end
