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
#import "JWBetTableViewController.h"
#import "JWHome.h"

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
/*城市名称*/
@property (nonatomic, strong) NSArray *cityTitleArray1;
/*城市名称*/
@property (nonatomic, strong) NSArray *cityTitleArray2;

/*游戏中心数据*/
@property (nonatomic, strong) NSArray *DataArray;
/*开奖信息数据*/
@property (nonatomic, strong) NSArray *OpenInforArray;

/**当前时间戳*/
@property (nonatomic, assign) NSTimeInterval time;

@end

@implementation HomeViewController


- (NSArray *)DataArray{
    if (!_DataArray) {
        _DataArray =[NSArray array];
    }
    return _DataArray;
}
- (NSArray *)OpenInforArray{
    if (!_OpenInforArray) {
        _OpenInforArray =[NSArray array];
    }
    return _OpenInforArray;
}
- (NSArray *)cityImageArray1{
    if (!_cityImageArray1) {
        _cityImageArray1 =[NSArray arrayWithObjects:@"CityGame1",@"CityGame3",@"CityGame4",@"CityGame6",@"CityGame8",@"CityGame9", @"CityGame9",@"CityGame9",nil];
    }
    return _cityImageArray1;
}
- (NSArray *)cityImageArray2{
    if (!_cityImageArray2) {
        _cityImageArray2 =[NSArray arrayWithObjects:@"CityGame2",@"CityGame3",@"CityGame5",@"CityGame7",@"CityGame9",@"CityGame9",@"CityGame9",@"CityGame9", nil];
    }
    return _cityImageArray2;
}

- (NSArray *)cityTitleArray1{
    if (!_cityTitleArray1) {
        _cityTitleArray1 =[NSArray arrayWithObjects:@"PC蛋蛋",@"北京11",@"北京28",@"韩国11",@"韩国28", @"加拿大11",@"加拿大28",nil];
    }
    return _cityTitleArray1;
}
- (NSArray *)cityTitleArray2{
    if (!_cityTitleArray2) {
        _cityTitleArray2 =[NSArray arrayWithObjects:@"蛋蛋36",@"北京16",@"北京36",@"韩国16",@"韩国36",@"加拿大16",@"加拿大36",nil];
    }
    return _cityTitleArray2;
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
    //下拉刷新数据
    [self ViewrefreshData];
    //请求数据
    [self requestData];
    
}
/**请求数据*/
-(void)requestData{
    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    NSString *url =[MAINURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    parameters =nil;
     manager.responseSerializer.acceptableContentTypes =[manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/json"];
    [manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"首页%@",responseObject);
          self.DataArray =responseObject[@"data"][@"hall"];
        //开奖信息
          self.OpenInforArray =responseObject[@"data"][@"award_info"];
        NSLog(@"%@",self.OpenInforArray);
        
        //时间戳
        
        self.time =(int)[[NSDate dateWithTimeIntervalSinceNow:0]timeIntervalSince1970] ;
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         NSLog(@"首页错误%@",error);
    }];
}

- (void)ViewrefreshData{
    //数据刷新
    UIRefreshControl *refresh =[[UIRefreshControl alloc]init];
   
        [refresh addTarget:self action:@selector(refreshFirstData:) forControlEvents:UIControlEventValueChanged];
        [self.tableView addSubview:refresh];
  
   
}
//刷新开奖中心数据
- (void)refreshFirstData:(UIRefreshControl *)control{
    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    NSString *url =[MAINURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    parameters =nil;
    manager.responseSerializer.acceptableContentTypes =[manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/json"];
    [manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
        //数据请求
        [control endRefreshing];
        //游戏中心
       self.DataArray =responseObject[@"data"][@"hall"];
        //开奖信息
       self.OpenInforArray =responseObject[@"data"][@"award_info"];
      
        //时间戳
       self.time =(int)[[NSDate dateWithTimeIntervalSinceNow:0] timeIntervalSince1970] ;
       
       
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"首页错误%@",error);
    }];

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
        return 14;
    }
    else if (self.currentIndex == 13){
        return 2;
    }else{
        return self.DataArray.count/2;
    }
   
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
   
    if (self.currentIndex == 12) {
        InfoTableViewCell *cell =[InfoTableViewCell cellWithTableView:tableView];
        
        cell.GameType.text = [self gameType:self.OpenInforArray[indexPath.row][@"game_type"]];
        cell.stage.text = [NSString stringWithFormat:@"第%@期",self.OpenInforArray[indexPath.row][@"game_sn"]];
        //时间戳转换成时间
        NSInteger time = [self.OpenInforArray[indexPath.row][@"opened_at"] integerValue] ;
        NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
        NSDateFormatter*dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *currentDateStr = [dateFormatter stringFromDate:detaildate];
        cell.Time.text =currentDateStr;
        //结果显示
        NSString *number =self.OpenInforArray[indexPath.row][@"open_number"];
        cell.firstNumber.text = [number substringToIndex:1];
        unichar str2 = [number characterAtIndex:2];
        cell.secondNumber.text = [NSString stringWithFormat:@"%c",str2];
        if (number.length >= 5 ) { //16、28玩法
             unichar str3 = [number characterAtIndex:4];
             cell.ThreeNumber.text =[NSString stringWithFormat:@"%c",str3];
            if (number.length>5) {//36玩法
                 unichar sum = [number characterAtIndex:6];
                 cell.sumNumber.text = [self game:[NSString stringWithFormat:@"%c",sum]];
    
            } else{
               NSInteger sum =[cell.firstNumber.text integerValue] + [cell.secondNumber.text integerValue] +[cell.ThreeNumber.text integerValue];
                cell.sumNumber.text =[NSString stringWithFormat:@"%ld",sum];
            }
            
        } else if (number.length == 3) {//11玩法
            cell.changeAdd.text =@"=";
            cell.threeBg.image = [UIImage imageNamed:@""];
            cell.Sum.text =@"";
            cell.sumNumber.text =@"";
            NSInteger sum =[cell.firstNumber.text integerValue] + [cell.secondNumber.text integerValue];
            cell.ThreeNumber.text = [NSString stringWithFormat:@"%ld",sum];
        }
      
       
        
        
        return cell;
    } else if (self.currentIndex == 13){
        NewInfoTableViewCell *cell =[NewInfoTableViewCell cellWithTableView:tableView];
        return cell;
    } else {
       
        GameCenterTableViewCell *cell =[GameCenterTableViewCell cellWithTableView:tableView];
        //游戏名称
        
       
         cell.LeftCityName.text = [self gameType:self.DataArray[indexPath.row *2][@"game_type"]];
         cell.RightCityName.text = [self gameType:self.DataArray[indexPath.row *2+1][@"game_type"]];
        //游戏期号
        cell.LeftStage.text =[NSString stringWithFormat:@"第%@期",self.DataArray[indexPath.row *2][@"game_sn"]];
        cell.RightStage.text =[NSString stringWithFormat:@"第%@期",self.DataArray[indexPath.row *2+1][@"game_sn"]];
        //图片
        cell.LeftImage.image =[UIImage imageNamed:self.cityImageArray1[indexPath.row]];
        cell.RightImage.image =[UIImage imageNamed:self.cityImageArray2[indexPath.row]];
        
        NSInteger LefttimeEnd =[self.DataArray[indexPath.row *2][@"opened_at"]  integerValue];
        NSInteger RighttimeEnd =[self.DataArray[indexPath.row *2 +1][@"opened_at"]  integerValue];
        
        NSLog(@"%ld %ld",LefttimeEnd,(long)self.time);
       //倒计时时间
        [self startWithTime:LefttimeEnd -(long)self.time Label:cell.LeftTime];
        [self startWithTime:RighttimeEnd - (long)self.time Label:cell.RightTime];
        
        
        //奖池
        cell.LeftAwardMoney.text =[NSString stringWithFormat:@"奖池：%@",self.DataArray[indexPath.row *2][@"bet_amount"]];
        cell.RightAwardMoney.text =[NSString stringWithFormat:@"奖池：%@",self.DataArray[indexPath.row *2+1][@"bet_amount"]];
    
        [cell.LeftBtn setTitle:cell.LeftCityName.text forState:UIControlStateNormal];
        [cell.RightBtn setTitle: cell.RightCityName.text forState:UIControlStateNormal];
        [cell.LeftBtn setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
        [cell.RightBtn setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
        

        
        //左右按钮点击
        [cell.LeftBtn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.RightBtn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    
}

/**
 * 按钮点击 
 */
- (void)BtnClick:(UIButton *)sender{
   
    
    [self loadHistroyDataGameType:sender.currentTitle];
 
    
}


- (void)loadHistroyDataGameType:(NSString *)gameType{
    
    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes =[manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/json"];
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    NSString *url =[BETURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString *gametype =[self NmuberTogameType: gameType];
    [parameters setObject:gametype forKey:@"type"];
    [parameters setObject:@"1" forKey:@"is_history"];
    
   
    [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // NSLog(@"%@",responseObject);
        JWBetTableViewController *betVC = [[JWBetTableViewController alloc]init];
        betVC.cityName =gameType;
       
        betVC.historyData =responseObject[@"data"];
        //NSLog(@"历史记录%@",self.historyData);
        
        
        AFHTTPSessionManager *manager1 =[AFHTTPSessionManager manager];
        manager1.responseSerializer.acceptableContentTypes =[manager1.responseSerializer.acceptableContentTypes setByAddingObject:@"text/json"];
        
        NSMutableDictionary *parameters1 = [[NSMutableDictionary alloc]init];
        NSString *url =[LOADINGURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
       
        [parameters1 setObject:gametype forKey:@"type"];
        //[parameters setObject:@"16938614" forKey:@"sn"];
        
       // NSLog(@"%@",gametype);
        
        
        [manager1 POST:url parameters:parameters1 progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSString *string =[NSString stringWithFormat:@"%@",responseObject[@"code"]];
            if ([string isEqualToString:@"3002"]) {
                NSLog(@"3002");
            } else{
                betVC.WillOpen =responseObject[@"data"];
                [self.navigationController pushViewController:betVC animated:YES];
            }
                     NSLog(@"正在进行中%@",responseObject);
           
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
            
        }];
        
        
        
        
       
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        
    }];
    
    
    
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.currentIndex== 11) {
        return 100;
    }else {
        return 80;
    }
}
/**
 *倒计时
 */
- (void)startWithTime:(NSInteger)timeLine Label:(UILabel *)label{
    
    //倒计时时间
    __block NSInteger timeOut = timeLine;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    //每秒执行一次
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        
        //倒计时结束，关闭
        if (timeOut <= 0) {
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                label.text =@"开奖中";
                
            });
        } else {
           
            dispatch_async(dispatch_get_main_queue(), ^{
               // label.text = [NSString stringWithFormat:@"%ld",timeOut];
                int seconds =timeOut % 60;
                int minuter =(timeOut /60) %60;
                label.text =[NSString stringWithFormat:@"%d分%d秒",minuter,seconds];
            });
            timeOut--;
        }
    });
    dispatch_resume(_timer);
}
- (NSString *)gameType:(NSString *)gametype{
   
    if ([gametype isEqualToString:@"1112"]) {
        
        return @"北京11";
    } else if ([gametype isEqualToString:@"1116"]){
        return @"韩国11";
    }else if ([gametype isEqualToString:@"1118"]){
        return @"加拿大11";
    }else if ([gametype isEqualToString:@"1612"]){
        return @"北京16";
    }else if ([gametype isEqualToString:@"1616"]){
        return @"韩国16";
    }else if ([gametype isEqualToString:@"1618"]){
        return @"加拿大16";
    }else if ([gametype isEqualToString:@"2810"]){
        return @"蛋蛋28";
    }else if ([gametype isEqualToString:@"2812"]){
        return @"北京28";
    }else if ([gametype isEqualToString:@"2816"]){
        return @"韩国28";
    }else if ([gametype isEqualToString:@"2818"]){
        return @"加拿大28";
    }else if ([gametype isEqualToString:@"3610"]){
        return @"蛋蛋36";
    }else if ([gametype isEqualToString:@"3612"]){
        return @"北京36";
    }else if ([gametype isEqualToString:@"3616"]){
        return @"韩国36";
    }else if ([gametype isEqualToString:@"3618"]){
        return @"加拿大36";
    }
    return 0;
}
- (NSString *)NmuberTogameType:(NSString *)gametype{
    
    if ([gametype isEqualToString:@"北京11"]) {
        
        return @"1112";
    } else if ([gametype isEqualToString:@"韩国11"]){
        return @"1116";
    }else if ([gametype isEqualToString:@"加拿大11"]){
        return @"1118";
    }else if ([gametype isEqualToString:@"北京16"]){
        return @"1612";
    }else if ([gametype isEqualToString:@"韩国16"]){
        return @"1616";
    }else if ([gametype isEqualToString:@"加拿大16"]){
        return @"1618";
    }else if ([gametype isEqualToString:@"蛋蛋28"]){
        return @"2810";
    }else if ([gametype isEqualToString:@"北京28"]){
        return @"2812";
    }else if ([gametype isEqualToString:@"韩国28"]){
        return @"2816";
    }else if ([gametype isEqualToString:@"加拿大28"]){
        return @"2818";
    }else if ([gametype isEqualToString:@"蛋蛋36"]){
        return @"3610";
    }else if ([gametype isEqualToString:@"北京36"]){
        return @"3612";
    }else if ([gametype isEqualToString:@"韩国36"]){
        return @"3616";
    }else if ([gametype isEqualToString:@"加拿大36"]){
        return @"3618";
    }
    return 0;
}

- (NSString *)game:(NSString *)game{
    
    if ([game isEqualToString:@"1"]) {
        return @"豹";
    } else if ([game isEqualToString:@"3"]) {
        return @"顺";
    }else if ([game isEqualToString:@"5"]) {
        return @"对";
    }else if ([game isEqualToString:@"7"]) {
        return @"半";
    }else if ([game isEqualToString:@"9"]) {
        return @"杂";
    }
    return 0;
}

@end
