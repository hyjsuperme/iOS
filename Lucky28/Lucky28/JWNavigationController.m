//
//  JWNavigationController.m
//  Lucky28
//
//  Created by hyj-pc on 16/10/25.
//  Copyright © 2016年 Jiuwang. All rights reserved.
//

#import "JWNavigationController.h"
#import "UIBarButtonItem+Extension.h"

@interface JWNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation JWNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
 //设置导航栏背景图片
    self.interactivePopGestureRecognizer.delegate =self;
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"Navi_Background"] forBarMetrics:UIBarMetricsDefault];
    //设置导航栏title字体大小，颜色
    [self.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:[UIColor whiteColor]}];
}
/**
 *重新push方法的目的：拦截所有进来的子控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count >0) {
        // 隐藏底部的工具条
        viewController.hidesBottomBarWhenPushed = YES;
       
       // [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"navigationButtonReturn" highImage:@"navigationButtonReturn"];
      

    }
    // 所有设置搞定后, 再push控制器
    [super pushViewController:viewController animated:animated];
}
- (void)back{
    [self popViewControllerAnimated:YES];
}

@end
