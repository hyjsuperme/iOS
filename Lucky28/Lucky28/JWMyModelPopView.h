//
//  JWMyModelPopView.h
//  Lucky28
//
//  Created by 九旺网络 on 2016/11/10.
//  Copyright © 2016年 Jiuwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JWMyModelPopView : UIWindow
@property (nonatomic ,strong) NSMutableArray* ModelArray;
@property (nonatomic, strong) NSString *Style;
- (void)show;
@end
