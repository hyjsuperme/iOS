//
//  BetingBallTableViewCell.m
//  Lucky28
//
//  Created by 九旺网络 on 2016/11/8.
//  Copyright © 2016年 Jiuwang. All rights reserved.
//

#import "BetingBallTableViewCell.h"

@interface BetingBallTableViewCell ()
@property (nonatomic, strong) UIButton *selectedBtn;
@end
@implementation BetingBallTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    NSLog(@"投注金额%@",self.textField.text);
}


+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID =@"identifer";
   BetingBallTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
       cell =[[[NSBundle mainBundle]loadNibNamed:@"BetingBallTableViewCell" owner:nil options:nil]lastObject];
    }
    return cell;
}
- (IBAction)OddsClick:(UIButton *)sender {
    sender.selected =YES;
    self.selectedBtn.selected =NO;
    self.selectedBtn =sender;
    NSMutableString *string =[NSMutableString stringWithString:sender.currentTitle];
    [string deleteCharactersInRange:NSMakeRange(sender.currentTitle.length-1,1)];
    float odd = [string floatValue];
    float money =[self.textField.text integerValue] *odd;
    if (money <=1) {
        self.textField.text =@"1";
    }else{
        self.textField.text =[NSString stringWithFormat:@"%ld",(NSInteger)money];
    }
  
}


@end
