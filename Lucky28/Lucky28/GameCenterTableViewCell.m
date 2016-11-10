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

@end

@implementation GameCenterTableViewCell


+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID =@"ID1";
    GameCenterTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell =[[[NSBundle mainBundle]loadNibNamed:@"GameCenterTableViewCell" owner:nil options:nil]firstObject];
    }
    return cell;
}
- (void)setHome:(JWHome *)home{
    _home =home;
    //左右游戏类型
//    self.LeftCityName.text =_home.game_type;
//    self.RightCityName.text =_home.game_type;
//    //游戏期号
//    self.LeftStage.text =_home.game_sn;
//    self.RightStage.text =_home.game_sn;
//    //开奖时间
//    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970] * 1000;
//    NSInteger timeEnd =[_home.opened_at  integerValue];
//    
//    self.LeftTime.text =[NSString stringWithFormat:@"%f",timeEnd -interval];
//    self.RightTime.text =[NSString stringWithFormat:@"%f",timeEnd -interval];
//    //奖池
//    self.LeftAwardMoney.text =_home.bet_amount;
//    self.LeftAwardMoney.text =_home.bet_amount;
    
}
//左边按钮点击
- (IBAction)LeftBtnClick:(UIButton *)sender {
    
}
//右边按钮点击
- (IBAction)RightBtnClick:(UIButton *)sender {
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
   
}


@end
