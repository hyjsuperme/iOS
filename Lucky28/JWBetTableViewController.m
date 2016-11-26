//
//  JWBetTableViewController.m
//  Lucky28
//
//  Created by 九旺网络 on 2016/10/28.
//  Copyright © 2016年 Jiuwang. All rights reserved.
//

#import "JWBetTableViewController.h"
#import "BetTableViewCell.h"
#import "JWTableViewCell.h"
#import "JWBettingTableViewController.h"
@interface JWBetTableViewController ()
@property (nonatomic, strong) NSArray *BetData;

@property (nonatomic, assign) int indexOpen;
@property (nonatomic, assign) NSTimeInterval time;

@end

@implementation JWBetTableViewController

- (NSMutableDictionary *)WillOpen{
    if (!_WillOpen) {
        _WillOpen =[NSMutableDictionary dictionary];
    }
    return _WillOpen;
}
- (NSArray *)BetData{
    if (!_BetData) {
        _BetData =[NSArray array];
    }
    return _BetData;
}
- (NSArray *)historyData{
    if (!_historyData) {
        _historyData =[NSArray array];
    }
    return _historyData;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =self.cityName;
    self.tableView.separatorStyle =UITableViewCellAccessoryNone;
    self.tableView.showsVerticalScrollIndicator =NO;
    NSLog(@"1111111111111111111111111111111111111111111===30=1934-92-349-2394-19-3492-1");
    //下拉刷新
    [self ViewrefreshData];
    //未开奖、已开奖
    [self loadData];
    //历史记录
    [self loadHistroyData];

}

- (void)loadingData{
    //[self.WillOpen removeAllObjects];
    NSLog(@"+++%@",self.WillOpen);
    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes =[manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/json"];
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    NSString *url =[LOADINGURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString *gametype =[self NmuberTogameType: self.cityName];
    [parameters setObject:gametype forKey:@"type"];
    //[parameters setObject:@"16938614" forKey:@"sn"];
    
    NSLog(@"%@",gametype);
    
    
    [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
      
        self.WillOpen =responseObject[@"data"];
          NSLog(@"正在进行中%@",self.WillOpen);
       
       [self.tableView reloadData];
         
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        
    }];
    
}
- (void)loadData{
    
    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes =[manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/json"];
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    NSString *url =[BETURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString *gametype =[self NmuberTogameType: self.cityName];
    [parameters setObject:gametype forKey:@"type"];
    
    
    [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
     
        
        self.BetData =responseObject[@"data"];
        NSLog(@"----%@",self.BetData);
      
        NSString *string ;
        for (int i = 0; i <self.BetData.count; i++) {
            string =[NSString stringWithFormat:@"%@", self.BetData[i][@"open_number"]];
            if ([string isEqualToString:@"<null>"]) {
                self.indexOpen =i;
            }
        }
       // self.willOpen = self.BetData[self.indexOpen];
//         NSLog(@"=====%@",self.willOpen);
        self.time =(int)[[NSDate dateWithTimeIntervalSinceNow:0] timeIntervalSince1970];
      [self.tableView reloadData];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        
    }];
    
}

/**
 *第一次进入
 */
- (void)loadHistroyData{
    
    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes =[manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/json"];
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    NSString *url =[BETURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString *gametype =[self NmuberTogameType: self.cityName];
    [parameters setObject:gametype forKey:@"type"];
    [parameters setObject:@"1" forKey:@"is_history"];
    
    
    [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // NSLog(@"%@",responseObject);
        
        self.historyData =responseObject[@"data"];
        NSLog(@"历史记录%@",self.historyData);
       
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        
    }];
}
/**
 *刷新历史数据
 */
- (void)loadHistroyData:(UIRefreshControl *)control{
    
    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes =[manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/json"];
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    NSString *url =[BETURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString *gametype =[self NmuberTogameType: self.cityName];
    [parameters setObject:gametype forKey:@"type"];
    [parameters setObject:@"1" forKey:@"is_history"];
    
    
    [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // NSLog(@"%@",responseObject);
        
        self.historyData =responseObject[@"data"];
        NSLog(@"历史记录%@",self.historyData);
        [control endRefreshing];
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        
    }];
}
- (void)ViewrefreshData{
    
    //数据刷新
    UIRefreshControl *refresh =[[UIRefreshControl alloc]init];
    [refresh addTarget:self action:@selector(refreshData:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refresh];
}
//刷新
- (void)refreshData:(UIRefreshControl *)control{
    [self loadData];
    [self loadingData];
    [self loadHistroyData:control];
    
   // [self loadHistroyData:control];
   
    //数据请求
    
    
    
    
   // [control endRefreshing];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    if (section == 0) {
         return 1;
    } else{
         return self.BetData.count;
    }
   
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
          BetTableViewCell *cell = [BetTableViewCell cellWithTableView:tableView];
          cell.selectionStyle =NO;
          [cell.BetButton addTarget:self action:@selector(BetButtonClick:) forControlEvents:UIControlEventTouchUpInside];
         if (indexPath.row < 5) {
          cell.BetButton.tag = (indexPath.row +1)*55;
         }
            //时间戳转换成时间
            NSInteger time = [self.BetData[indexPath.row][@"opened_at"] integerValue] ;
            NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
            NSDateFormatter*dateFormatter = [[NSDateFormatter alloc]init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm" ];
            NSString *currentDateStr = [dateFormatter stringFromDate:detaildate];
            cell.Time.text = [NSString stringWithFormat:@"开奖时间：%@",currentDateStr];
            //期号
            cell.Stage.text = [NSString stringWithFormat:@"第%@期",self.BetData[indexPath.row][@"game_sn"]];
        
            if (indexPath.row < 5) {
                cell.Stage.tag =(indexPath.row +1)*56;
            }
            NSString *progress =[NSString stringWithFormat:@"%@",self.BetData[indexPath.row][@"game_progress"]];
       
        
        if ([progress isEqualToString:@"12"]) {
            [cell.BetButton setBackgroundImage:[UIImage imageNamed:@"DoneButton"] forState:UIControlStateNormal];
            
        } else if ([progress isEqualToString:@"15"]){
             [cell.BetButton setBackgroundImage:[UIImage imageNamed:@"BetLoading"] forState:UIControlStateNormal];
             [cell.BetButton setTitle:@"正在开奖" forState:UIControlStateNormal];
             cell.BetButton.userInteractionEnabled =NO;
        } else if ([progress isEqualToString:@"18"] ){
            // NSLog(@"19000=====  %@",self.BetData[indexPath.row][@"open_number"]);
            NSString *Open =[NSString stringWithFormat:@"%@",self.BetData[indexPath.row][@"open_number"]];
            if ( ![Open isEqualToString:@"<null>"]) {
                
                [cell.BetButton setBackgroundImage:[UIImage imageNamed:@"BetEnd"] forState:UIControlStateNormal];
                [cell.BetButton setTitle:@"已开奖" forState:UIControlStateNormal];
                cell.BetButton.userInteractionEnabled =NO;
                
                cell.firstBg1.image =[UIImage imageNamed:@"Number_back"];
                cell.secondBg2.image = [UIImage imageNamed:@"Number_back"];
                cell.SumBg3.image =[UIImage imageNamed:@"Number_back"];
                cell.sumBg2.image = [UIImage imageNamed:@"YellowBall"];
                
                NSString *number =self.BetData[indexPath.row][@"open_number"];
               // NSLog(@"19000=====  %ld",(long)indexPath.row);
                cell.FirstNumbar.text = [number substringToIndex:1];
                unichar str2 = [number characterAtIndex:2];
                cell.SecondNumber.text = [NSString stringWithFormat:@"%c",str2];
                
                if (number.length >= 5 ) { //16、28玩法
                    unichar str3 = [number characterAtIndex:4];
                    cell.ThreeNumber.text =[NSString stringWithFormat:@"%c",str3];
                    if (number.length>5) {//36玩法
                        unichar sum = [number characterAtIndex:6];
                        cell.sumNumber.text = [self game:[NSString stringWithFormat:@"%c",sum]];
                        
                    } else{
                        NSInteger sum =[cell.FirstNumbar.text integerValue] + [cell.SecondNumber.text integerValue] +[cell.ThreeNumber.text integerValue];
                        cell.sumNumber.text =[NSString stringWithFormat:@"%ld",sum];
                    }
                    
                } else if (number.length == 3) {//11玩法
                    
                    cell.sumNumber.text =@"";
                    cell.sumBg2.image =[UIImage imageNamed:@""];
                    cell.sumBg1.image =[UIImage imageNamed:@"YellowBall"];
                    cell.sumSymbol1.text =@"=";
                    cell.ThreeNumber.text =@"";
                    cell.sumSymbol2.text =@"";
                    cell.SumBg3.image =[UIImage imageNamed:@""];
                    
                    
                    NSInteger sum =[cell.FirstNumbar.text integerValue] + [cell.SecondNumber.text integerValue];
                    cell.sum2.text = [NSString stringWithFormat:@"%ld",sum];
                }
            }
       
 }
            return cell;
    } else{
        JWTableViewCell *cell =[JWTableViewCell cellWithTableView:tableView];
        //左边期号
        cell.TopStage.text = [NSString stringWithFormat:@"第%@期",self.historyData[0][@"game_sn"]];
        //时间戳转换成时间
        NSInteger time = [self.historyData[indexPath.row][@"opened_at"] integerValue] ;
        NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
        NSDateFormatter*dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm" ];
        NSString *currentDateStr = [dateFormatter stringFromDate:detaildate];
        cell.TopTime.text = [NSString stringWithFormat:@"%@",currentDateStr];
        //右边期号
       // cell.EndStage.text =[NSString stringWithFormat:@"距离第%@期开奖仅需",self.willOpen[@"game_sn"]];
        NSString *strBet =[NSString stringWithFormat:@"%@",self.WillOpen[@"bettime"]];
         NSString *strstop =[NSString stringWithFormat:@"%@",self.WillOpen[@"stoptime"]];
        NSInteger bettime =[strBet integerValue];//投注时间
        NSInteger stoptime =[strstop integerValue];
        NSLog(@"bettime%@",strBet);
        NSString *stage =[NSString stringWithFormat:@"%@",self.WillOpen[@"currsn"]];
        if (bettime > 0) {
           
            cell.EndStage.text =[NSString stringWithFormat:@"第%@期 剩余投注时间",stage];
//            [self startWithTime:bettime Time1:cell.Time1 Time2:cell.Time2 Time3:cell.time3 Time4:cell.Time4 No:1];
            NSLog(@"剩余投注时间%ld", bettime);
        } else if(bettime == 0 ){
           
            cell.EndStage.text =[NSString stringWithFormat:@"第%@期 剩余开奖时间",stage];
//             [self startWithTime:stoptime Time1:cell.Time1 Time2:cell.Time2 Time3:cell.time3 Time4:cell.Time4 No:2];
             NSLog(@"剩余投注时间%ld", stoptime);
        }
       ;
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        //时间戳转换成时间
       // NSInteger differTime =[self.willOpen[@"opened_at"] integerValue] - self.time;
      //
       // NSLog(@"----------------+%ld" ,differTime );
       
        NSString *number =self.historyData[0][@"open_number"];
        cell.FirstNumber.text = [number substringToIndex:1];
        unichar str2 =[number characterAtIndex:2];
        cell.SecondNumber.text =[NSString stringWithFormat:@"%c",str2];
        if (number.length >= 5 ) { //16、28玩法
            cell.firstAddSymbol.text =@"";
            cell.DoubleSumBg.image =[UIImage imageNamed:@""];
            cell.DoubleSum.text =@"";
            cell.secondAddSymbol.text =@"=";
            cell.ThreeSumBg.image =[UIImage imageNamed:@"YellowBall"];
            unichar str3 = [number characterAtIndex:4];
            cell.ThreeNumber.text =[NSString stringWithFormat:@"%c",str3];
            if (number.length>5) {//36玩法
                unichar sum = [number characterAtIndex:6];
                cell.SumNumber.text = [self game:[NSString stringWithFormat:@"%c",sum]];
                
            } else{
                NSInteger sum =[cell.FirstNumber.text integerValue] + [cell.SecondNumber.text integerValue] +[cell.ThreeNumber.text integerValue];
                cell.SumNumber.text =[NSString stringWithFormat:@"%ld",sum];
            }
            
        } else if (number.length == 3) {//11玩法
            
            cell.SumNumber.text =@"";
            cell.ThreeSumBg.image =[UIImage imageNamed:@""];
            cell.DoubleSumBg.image =[UIImage imageNamed:@"YellowBall"];
            cell.ThreeNumberBg.image =[UIImage imageNamed:@""];
            cell.ThreeNumber.text=@"";
            cell.secondAddSymbol.text =@"";
            cell.firstAddSymbol.text =@"=";
            NSInteger sum =[cell.FirstNumber.text integerValue] + [cell.SecondNumber.text integerValue];
            cell.DoubleSum.text = [NSString stringWithFormat:@"%ld",sum];
        }
        
          cell.selectionStyle =NO;
            return cell;
    }
    

}
/**
 *点击下注按钮
// */
- (void)BetButtonClick:(UIButton *)sender{
    UILabel *stage =[self.view viewWithTag:sender.tag/55*56];
    NSMutableString *mstring =[NSMutableString stringWithString:stage.text];
    [mstring deleteCharactersInRange:NSMakeRange(0, 1)];
    [mstring deleteCharactersInRange:NSMakeRange(mstring.length -1, 1)];
   
    
    NSLog(@"%@",mstring);
    
    JWBettingTableViewController *bettingVC =[[JWBettingTableViewController alloc]init];
    
    bettingVC.CityName =self.cityName;
    
    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes =[manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/json"];
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    NSString *url =[ODDSURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString *gametype =[NSString NmuberTogameType: self.cityName];
    [parameters setObject:gametype forKey:@"type"];//游戏类型
    [parameters setObject:mstring forKey:@"sn"];//游戏期号
    
    NSLog(@"%@ %@",gametype,mstring);
    [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"😁参数：%@",responseObject);
        bettingVC.Odds =responseObject[@"data"][@"odds"];
        NSString *sn =[NSString stringWithFormat:@"%@",mstring];
        bettingVC.sn =sn;
        
#warning ----------------------------------------------------
        AFHTTPSessionManager *manager1 =[AFHTTPSessionManager manager];
        manager1.responseSerializer.acceptableContentTypes =[manager1.responseSerializer.acceptableContentTypes setByAddingObject:@"text/json"];
        
        NSMutableDictionary *parameters1 = [[NSMutableDictionary alloc]init];
        NSString *url1 =[CHIPSURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [parameters1 setObject:@"34260172" forKey:@"user_number"];//游戏期号
        
       // NSLog(@"%@ %@",gametype1,mstring);
        [manager1 POST:url1 parameters:parameters1 progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            
            NSLog(@"参数：%@",responseObject);
            bettingVC.userMoney =responseObject[@"data"];
            [self.navigationController pushViewController:bettingVC animated:YES];
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
            
        }];
        

        
        
        
        
       
        // [self.navigationController pushViewController:bettingVC animated:YES];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        
    }];
    
   
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 100;
    } else{
        return 80;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
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
/**
 *倒计时
 */
- (void)startWithTime:(NSInteger)timeLine Time1:(UILabel *)time1 Time2:(UILabel *)time2 Time3:(UILabel *)time3 Time4:(UILabel *)time4 No:(NSInteger)No{
    
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
           
            // [self loadingData];
            //NSLog(@"923048102834012830481098340912");
            dispatch_async(dispatch_get_main_queue(), ^{
                time1.text =[NSString stringWithFormat:@"0"];
                time2.text =[NSString stringWithFormat:@"0"];
                time3.text =[NSString stringWithFormat:@"0"];
                time4.text =[NSString stringWithFormat:@"0"];
                [self loadData];
                [self loadingData];
                [self historyData];
               // [self.tableView reloadData];
              
            });
          
            [self loadingData];
        } else {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //label.text = [NSString stringWithFormat:@"%ld",timeOut];
                int seconds =timeOut % 60;
                int secone1 = seconds /10;
                int second2 =seconds %10;
                int minuter =(timeOut /60) %60;
                int minuter1 =minuter / 10;
                int minuter2 =minuter %10;
                
                time1.text =[NSString stringWithFormat:@"%d",minuter1];
                time2.text =[NSString stringWithFormat:@"%d",minuter2];
                time3.text =[NSString stringWithFormat:@"%d",secone1];
                time4.text =[NSString stringWithFormat:@"%d",second2];
                if (No == 1) {
                    time1.textColor =JWColorA(80, 171, 54, 1);
                    time2.textColor =JWColorA(80, 171, 54, 1);
                    time3.textColor =JWColorA(80, 171, 54, 1);
                    time4.textColor =JWColorA(80, 171, 54, 1);
                } else if (No == 2){
                    time1.textColor =[UIColor redColor];
                    time2.textColor =[UIColor redColor];
                    time3.textColor =[UIColor redColor];
                    time4.textColor =[UIColor redColor];
                }
                
               
               // label.text =[NSString stringWithFormat:@"%d分%d秒",minuter,seconds];
            });
            timeOut--;
        }
    });
    dispatch_resume(_timer);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",indexPath.row);
}
@end
