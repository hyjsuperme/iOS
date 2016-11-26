//
//  JWBettingTableViewCell.m
//  Lucky28
//
//  Created by 九旺网络 on 2016/10/31.
//  Copyright © 2016年 Jiuwang. All rights reserved.
//

#import "JWBettingTableViewCell.h"

@interface JWBettingTableViewCell ()
@property (nonatomic, strong) UIButton *selectBtn;

@end


@implementation JWBettingTableViewCell

- (void)setBetArray:(NSArray *)betArray{
    _betArray =betArray;
   
    NSInteger Tag;
    
        for (int i = 0; i < betArray.count; i++) {
            if (self.oddsCount == 5) {
            Tag =([betArray[i] integerValue]+1) *100;
            }else if (self.oddsCount == 11){
                Tag =([betArray[i] integerValue]-1) *100;
            }else if (self.oddsCount == 16){
                 Tag =([betArray[i] integerValue]-2) *100;
            } else{
                Tag =([betArray[i] integerValue]+1) *100;
            }
    
            UIButton *button =[self viewWithTag:Tag];
            [button setBackgroundImage:[UIImage imageNamed:@"Number_back"] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            button.selected =YES;
        }
    NSLog(@"123");
   
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID =@"ID";
    JWBettingTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell =[[[NSBundle mainBundle]loadNibNamed:@"JWBettingTableViewCell" owner:nil options:nil]firstObject];
    }
    return cell;
}
- (IBAction)Click:(UIButton *)sender {

     sender.selected =!sender.selected;
    NSString *selectNumber;
    if (self.oddsCount == 5) {
        selectNumber =[NSString Game36:sender.currentTitle];
    } else if (self.oddsCount == 11){
        selectNumber =[NSString stringWithFormat:@"%ld",[sender.currentTitle integerValue] -2];
    }else if (self.oddsCount == 16){
        selectNumber =[NSString stringWithFormat:@"%ld",[sender.currentTitle integerValue] -3];
    } else{
        selectNumber =sender.currentTitle;
    }
    if (sender.selected) {
        
        NSNotificationCenter *center =[NSNotificationCenter defaultCenter];
        [center postNotificationName:@"ButtonNameAdd" object:self userInfo:@{@"ButtonName":selectNumber}];
        [sender setBackgroundImage:[UIImage imageNamed:@"Number_back"] forState:UIControlStateNormal];
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    } else {
        NSNotificationCenter *center =[NSNotificationCenter defaultCenter];
        [center postNotificationName:@"ButtonNameRemove" object:self userInfo:@{@"ButtonName":selectNumber}];
        [sender setBackgroundImage:[UIImage imageNamed:@"WhiteBall"] forState:UIControlStateNormal];
        [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }

  
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Initialization code
   
}


@end
