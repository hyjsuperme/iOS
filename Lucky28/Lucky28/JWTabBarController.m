//
//  JWTabBarController.m
//  Lucky28
//
//  Created by hyj-pc on 16/10/24.
//  Copyright © 2016年 Jiuwang. All rights reserved.
//

#import "JWTabBarController.h"
#import "JWNavigationController.h"
#import "JWTabBar.h"

@interface JWTabBarController ()

@end

@implementation JWTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    /**设置所有UITableBarItem*/
    //普通状态下的文字属性
    UITabBarItem *item =[UITabBarItem appearance];
    [[UITabBar appearance] setBarTintColor:JWTabBarBackgroundColor];
    NSMutableDictionary *normalAttrs =[NSMutableDictionary dictionary];
    normalAttrs[NSFontAttributeName] =[UIFont systemFontOfSize:17];
    normalAttrs[NSForegroundColorAttributeName ] =[UIColor grayColor];
    [item setBadgeTextAttributes:normalAttrs forState:UIControlStateNormal];
    
    //选中状态下的文字属性
    NSMutableDictionary *selectedAttrs =[NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName]=JWTitleColor;
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    [self setUpOneChildViewController:[[JWNavigationController alloc]initWithRootViewController:[[HomeViewController alloc]init]] title:@"首页" image:@"" selectedImage:@""];
    [self setUpOneChildViewController:[[JWNavigationController alloc]initWithRootViewController:[[GameCenterViewController alloc]init]] title:@"活动" image:@"" selectedImage:@""];
    [self setUpOneChildViewController:[[JWNavigationController alloc]initWithRootViewController:[[ListViewController alloc]init] ] title:@"排行榜" image:@"" selectedImage:@""];
    [self setUpOneChildViewController:[[JWNavigationController alloc]initWithRootViewController:[[ExpiryViewController alloc]init]] title:@"抽奖" image:@"" selectedImage:@""];
    [self setUpOneChildViewController:[[JWNavigationController alloc]initWithRootViewController:[[MyViewController alloc]init]] title:@"我的" image:@"" selectedImage:@""];
    [self setValue:[[JWTabBar alloc]init] forKey:@"tabBar"];
  
}
- (void)setUpOneChildViewController:(UIViewController *)VC title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
    VC.view.backgroundColor =JWColorA(238, 238, 238, 1);;
    VC.tabBarItem.title =title;
    if (image.length) {
        VC.tabBarItem.image =[UIImage imageNamed:image];
        VC.tabBarItem.selectedImage =[UIImage imageNamed:selectedImage];
    }
    [self addChildViewController:VC];
}


@end
