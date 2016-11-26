//
//  JWMyModelPopView.h
//  Lucky28
//
//  Created by 九旺网络 on 2016/11/10.
//  Copyright © 2016年 Jiuwang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^BlockBetNumber)(NSMutableDictionary *BetDic ,NSMutableArray *BetArray);

@interface JWMyModelPopView : UIWindow

@property (nonatomic, copy) BlockBetNumber betDics;
@property (nonatomic ,strong) NSMutableArray* ModelArray;
@property (nonatomic, strong) NSString *Style;

- (void)handleForBetType:(BlockBetNumber)block;
- (void)show;
@end
