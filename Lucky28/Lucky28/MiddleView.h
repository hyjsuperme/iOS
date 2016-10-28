//
//  MiddleView.h
//  Lucky28
//
//  Created by 九旺网络 on 2016/10/26.
//  Copyright © 2016年 Jiuwang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^Block_Index)(NSInteger currentIndex);

@interface MiddleView : UIView
@property (nonatomic, copy) Block_Index index;
- (void)HandleCurrentIndex:(Block_Index)block;
@end
