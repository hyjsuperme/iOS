//
//  JWBettingTableViewCell.h
//  Lucky28
//
//  Created by 九旺网络 on 2016/10/31.
//  Copyright © 2016年 Jiuwang. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface JWBettingTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *Bet1;
@property (weak, nonatomic) IBOutlet UIButton *Bet2;
@property (weak, nonatomic) IBOutlet UIButton *Bet3;
@property (weak, nonatomic) IBOutlet UIButton *Bet4;
@property (weak, nonatomic) IBOutlet UIButton *Bet5;
@property (weak, nonatomic) IBOutlet UIButton *bet6;
@property (weak, nonatomic) IBOutlet UIButton *Bet7;
@property (weak, nonatomic) IBOutlet UIButton *Bet8;
@property (weak, nonatomic) IBOutlet UIButton *Bet9;
@property (weak, nonatomic) IBOutlet UIButton *Bet10;
@property (weak, nonatomic) IBOutlet UIButton *Bet11;
@property (weak, nonatomic) IBOutlet UIButton *Bet12;
@property (weak, nonatomic) IBOutlet UIButton *Bet13;
@property (weak, nonatomic) IBOutlet UIButton *Bet14;
@property (weak, nonatomic) IBOutlet UIButton *Bet15;
@property (weak, nonatomic) IBOutlet UIButton *Bet16;
@property (weak, nonatomic) IBOutlet UIButton *Bet17;
@property (weak, nonatomic) IBOutlet UIButton *Bet18;
@property (weak, nonatomic) IBOutlet UIButton *Bet19;
@property (weak, nonatomic) IBOutlet UIButton *Bet20;
@property (weak, nonatomic) IBOutlet UIButton *Bet21;
@property (weak, nonatomic) IBOutlet UIButton *Bet22;
@property (weak, nonatomic) IBOutlet UIButton *Bet23;
@property (weak, nonatomic) IBOutlet UIButton *Bet24;
@property (weak, nonatomic) IBOutlet UIButton *Bet25;
@property (weak, nonatomic) IBOutlet UIButton *Bet26;
@property (weak, nonatomic) IBOutlet UIButton *Bet27;
@property (weak, nonatomic) IBOutlet UIButton *Bet28;

/**赔率个数*/
@property (nonatomic, assign) NSInteger oddsCount;
@property (nonatomic, strong) NSArray *betArray;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
