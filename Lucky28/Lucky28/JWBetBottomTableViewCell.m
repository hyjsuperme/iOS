//
//  JWBetBottomTableViewCell.m
//  Lucky28
//
//  Created by 九旺网络 on 2016/10/31.
//  Copyright © 2016年 Jiuwang. All rights reserved.
//

#import "JWBetBottomTableViewCell.h"

@implementation JWBetBottomTableViewCell


+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID =@"ID";
    JWBetBottomTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell =[[[NSBundle mainBundle]loadNibNamed:@"JWBetBottomTableViewCell" owner:nil options:nil]firstObject];
    }
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)Timesclick:(UIButton *)sender {
    NSInteger timesN =[self.times.text integerValue];
    if ([sender.currentTitle isEqualToString:@"-"]) {
        timesN--;
        if (timesN >=0) {
            self.times.text = [NSString stringWithFormat:@"%ld",timesN];
        }
       
    }else{
        timesN++;
        self.times.text = [NSString stringWithFormat:@"%ld",timesN];
        NSLog(@"+++++%ld",timesN);
      
    }
    NSNotificationCenter *center =[NSNotificationCenter defaultCenter];
    [center postNotificationName:@"TimesAdd" object:self userInfo:@{@"TimesAdd":self.times.text}];
    
}
- (IBAction)StageClick:(UIButton *)sender {
    NSInteger stageN =[self.stage.text integerValue];
    if ([sender.currentTitle isEqualToString:@"-"]) {
        stageN--;
        if (stageN >=0) {
            self.stage.text = [NSString stringWithFormat:@"%ld",stageN];
        }
        
    }else{
        stageN++;
        self.stage.text = [NSString stringWithFormat:@"%ld",stageN];
       // NSLog(@"+++++%ld",stageN);
    }
}


@end
