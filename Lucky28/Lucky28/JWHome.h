//
//  JWHome.h
//  Lucky28
//
//  Created by 九旺网络 on 2016/10/31.
//  Copyright © 2016年 Jiuwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JWHome : NSObject
/**游戏类型*/
@property (nonatomic, copy) NSString *game_type;
/**当前期下注总金额*/
@property (nonatomic, copy) NSString *bet_amount;
/**开奖时间*/
@property (nonatomic, copy) NSString *opened_at;
/**开奖期号*/
@property (nonatomic, copy) NSString *game_sn;



@end
