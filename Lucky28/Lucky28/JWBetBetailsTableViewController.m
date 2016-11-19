//
//  JWBetBetailsTableViewController.m
//  Lucky28
//
//  Created by 九旺网络 on 2016/11/18.
//  Copyright © 2016年 Jiuwang. All rights reserved.
//

#import "JWBetBetailsTableViewController.h"
#import "JWBetBetailsTableViewCell.h"

@interface JWBetBetailsTableViewController ()

@end

@implementation JWBetBetailsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath { 
    JWBetBetailsTableViewCell *cell =[JWBetBetailsTableViewCell cellWithTableView:tableView];
    cell.GameType.text =self.title;//游戏类型
    NSString *code =[NSString stringWithFormat:@"%@",self.details[@"code"]];

    if ([code isEqualToString:@"0000"]) {
        cell.YesOrNo.image =[UIImage imageNamed:@"YesImage"];
        cell.Success.text =@"投注成功";
    }else{
        cell.YesOrNo.image =[UIImage imageNamed:@""];
        cell.Success.text =@"投注失败";
    }
    
//   cell.OpenNumber  是否开奖
    cell.Stage.text =[NSString stringWithFormat:@"%@期",self.stage];
    cell.BetMoney.text =[NSString stringWithFormat:@"%@",self.details[@"bet"]];
    cell.Time.text =[NSString stringWithFormat:@"%@",self.details[@"opentime"]];
    cell.FirstNumber.text =[NSString stringWithFormat:@"%@",self.details[@"openno"][0]];
    cell.SecondNumber.text =[NSString stringWithFormat:@"%@",self.details[@"openno"][1]];
    cell.ThreeNumber.text =[NSString stringWithFormat:@"%@",self.details[@"openno"][2]];
    cell.Sum.text =[NSString stringWithFormat:@"%@",self.details[@"final"]];
  
    
   
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 430;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
