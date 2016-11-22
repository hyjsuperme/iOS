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
//    [self.SecondBtn setBackgroundImage:[UIImage imageNamed:@"YesBtn"] forState:UIControlStateHighlighted];
//    [self.ThreeBtn setBackgroundImage:[UIImage imageNamed:@"YesBtn"] forState:UIControlStateHighlighted];
//    [self.FourBtn setBackgroundImage:[UIImage imageNamed:@"YesBtn"] forState:UIControlStateHighlighted];
//    sender.selected =YES;
//    if (sender == self.selectedBtn) {
//        return;
//    }
//    self.selectedBtn.selected =NO;
//    self.selectedBtn =sender;
    NSMutableString *string =[NSMutableString stringWithString:sender.currentTitle];
    [string deleteCharactersInRange:NSMakeRange(sender.currentTitle.length-1,1)];
    float odd = [string floatValue];
    float money =[self.textField.text integerValue] *odd;

    if (money <1.0) {
        money =1;
    }
        NSNotificationCenter *center =[NSNotificationCenter defaultCenter];
        [center postNotificationName:@"BetMoney" object:self userInfo:@{@"Money":[NSString stringWithFormat:@"%ld",(NSInteger)money] ,@"Number":self.NumberBtn.currentTitle}];
   
   
  
}


@end
