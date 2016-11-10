//
//  BetDefaultPopView.h
//  Lucky28
//
//  Created by 九旺网络 on 2016/11/2.
//  Copyright © 2016年 Jiuwang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^BlockBetType)(NSMutableArray *BetArray ,NSInteger BetTag);
@interface BetDefaultPopView : UIWindow
@property (nonatomic, assign) NSInteger betName;
@property (nonatomic, copy) BlockBetType betArray;
@property (nonatomic, strong) UIButton *ChooseBtn;
- (void)handleForBetType:(BlockBetType)block;
- (void)show;
- (void)dismiss;
@end
