//
//  JWNavigationController.m
//  Lucky28
//
//  Created by hyj-pc on 16/10/25.
//  Copyright © 2016年 Jiuwang. All rights reserved.
//

#import "JWNavigationController.h"

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

        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [backButton setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        [backButton setTitle:@"返回" forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [backButton sizeToFit];
        // 这句代码放在sizeToFit后面
        backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        // 隐藏底部的工具条
        viewController.hidesBottomBarWhenPushed = YES;

    }
    // 所有设置搞定后, 再push控制器
    [super pushViewController:viewController animated:animated];
}
- (void)back{
    
}

@end
