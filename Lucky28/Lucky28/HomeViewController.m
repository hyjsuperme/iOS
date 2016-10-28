//
//  HomeViewController.m
//  Lucky28
//
//  Created by 九旺网络 on 2016/10/25.
//  Copyright © 2016年 Jiuwang. All rights reserved.
//

#import "HomeViewController.h"
#import "HeaderView.h"
#import "MiddleView.h"
#import "InformView.h"
#import "GameCenterTableViewCell.h"
#import "NewInfoTableViewCell.h"
#import "InfoTableViewCell.h"

@interface HomeViewController () <UITableViewDataSource,UITableViewDelegate>
/**头部视图*/
@property (nonatomic, strong) HeaderView *headerView;
/**通知*/
@property (nonatomic, strong) InformView *informView;
/**中间切换视图*/
@property (nonatomic, strong) MiddleView *MiddleView;
/**选中的按钮下标*/
@property (nonatomic, assign) NSInteger currentIndex;
/**创建TableView*/
@property (nonatomic, strong) UITableView *tableView;
/**创建TableView*/
@property (nonatomic, strong) UILabel *headerMessage;
/*城市图片*/
@property (nonatomic, strong) NSArray *cityImageArray1;
/*城市图片*/
@property (nonatomic, strong) NSArray *cityImageArray2;





@end

@implementation HomeViewController

- (NSArray *)cityImageArray1{
    if (!_cityImageArray1) {
        _cityImageArray1 =[NSArray arrayWithObjects:@"CityGame1",@"CityGame3",@"CityGame4",@"CityGame6",@"CityGame8", nil];
    }
    return _cityImageArray1;
}
- (NSArray *)cityImageArray2{
    if (!_cityImageArray2) {
        _cityImageArray2 =[NSArray arrayWithObjects:@"CityGame2",@"CityGame3",@"CityGame5",@"CityGame7",@"CityGame9", nil];
    }
    return _cityImageArray2;
}
/**头部视图懒加载*/
- (HeaderView *)headerView{
    if (!_headerView) {
        _headerView =[[HeaderView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT *0.20)];
        _headerView.backgroundColor =[UIColor yellowColor];
    }
    return _headerView;
}

/**头部视图懒加载*/
- (InformView *)informView{
    if (!_informView) {
        _informView =[[InformView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT *0.20 +65,SCREEN_WIDTH, SCREEN_HEIGHT *0.06)];
        _informView.backgroundColor =[UIColor whiteColor];
    }
    return _informView;
}

/**中间视图懒加载*/
- (MiddleView *)MiddleView{
    if (!_MiddleView) {
        _MiddleView =[[MiddleView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT *0.20 +110, SCREEN_WIDTH, SCREEN_HEIGHT *0.06)];
        _MiddleView.backgroundColor =[UIColor redColor];
        [_MiddleView HandleCurrentIndex:^(NSInteger currentIndex) {
            self.currentIndex =currentIndex;
            if (self.currentIndex == 11) {
                self.headerMessage.text =@"28游戏";
            } else if(self.currentIndex == 12){
                self.headerMessage.text =@"开奖信息";
            } else{
                self.headerMessage.text =@"最新活动";
            }
            [self.tableView reloadData];
        }];
    }
    return _MiddleView;
}

/**底部的tableview*/
- (UITableView *)tableView{
  
    if (!_tableView) {
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT *0.26 +110, SCREEN_WIDTH, SCREEN_HEIGHT *0.505)];
        _tableView.dataSource =self;
        _tableView.delegate =self;
        self.tableView.showsVerticalScrollIndicator = NO;
        UIView *headView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT *0.06)];
       
        UIImageView *image =[[UIImageView alloc]initWithFrame:CGRectMake(0, 5, 4, SCREEN_HEIGHT *0.06 -10)];
        image.image =[UIImage imageNamed:@"headerLeftLin"];
        [headView addSubview:image];
       self.headerMessage =[[UILabel alloc]initWithFrame:CGRectMake(20, 5, 80, SCREEN_HEIGHT *0.06 -10)];
        self.headerMessage.text =@"28游戏";
        self.headerMessage.textColor =JWColorA(70, 70, 70, 1);
        [headView addSubview:self.headerMessage];
        UILabel *label1 =[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH *0.85, 5, 80, SCREEN_HEIGHT *0.06 -10)];
        label1.text =@"更多";
        label1.textColor =JWColorA(150, 150, 150, 1);
        label1.font =[UIFont systemFontOfSize:12.0f];
        [headView addSubview:label1];
        
        self.tableView.tableHeaderView =headView;
        self.tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
        
    }
    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"28娱乐";
    //设置头部视图
    [self setHeadView];
    //设置通知视图
    [self setInformView];
    //设置中部选中视图
    [self setMiddleView];
    //设置低部选tableview
    [self setBottomTableView];
    
    
    
    
}




- (void)setHeadView{
    [self.view addSubview:self.headerView];
}
- (void)setInformView{
    [self.view addSubview:self.informView];
}
- (void)setMiddleView{
    [self.view addSubview:self.MiddleView];
}
- (void)setBottomTableView{
    
    [self.view addSubview:self.tableView];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.currentIndex == 12) {
        return 10;
    }
    else if (self.currentIndex == 13){
        return 2;
    }else{
         return 5;
    }
   
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
   
    if (self.currentIndex == 12) {
        InfoTableViewCell *cell =[InfoTableViewCell cellWithTableView:tableView];
        
        return cell;
    } else if (self.currentIndex == 13){
        NewInfoTableViewCell *cell =[NewInfoTableViewCell cellWithTableView:tableView];
        return cell;
    } else {
        GameCenterTableViewCell *cell =[GameCenterTableViewCell cellWithTableView:tableView];
      
             cell.LeftImage.image =[UIImage imageNamed:self.cityImageArray1[indexPath.row]];
             cell.RightImage.image =[UIImage imageNamed:self.cityImageArray2[indexPath.row]];
 
       
       

        return cell;
    }
    
   
    

   
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.currentIndex== 11) {
        return 100;
    }else {
        return 80;
    }
}

@end
