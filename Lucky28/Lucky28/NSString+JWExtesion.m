//
//  NSString+JWExtesion.m
//  Lucky28
//
//  Created by 九旺网络 on 2016/11/16.
//  Copyright © 2016年 Jiuwang. All rights reserved.
//

#import "NSString+JWExtesion.h"

@implementation NSString (JWExtesion)
+ (NSString *)NmuberTogameType:(NSString *)gametype{
    
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

+ (NSString *)CodeForType:(NSString *)code{
     
    if ([code isEqualToString:@"1112"]) {
        
        return @"11";
    } else if ([code isEqualToString:@"1116"]){
        return @"11";
    }else if ([code isEqualToString:@"1118"]){
        return @"11";
    }else if ([code isEqualToString:@"1612"]){
        return @"16";
    }else if ([code isEqualToString:@"1616"]){
        return @"16";
    }else if ([code isEqualToString:@"1618"]){
        return @"16";
    }else if ([code isEqualToString:@"2810"]){
        return @"28";
    }else if ([code isEqualToString:@"2812"]){
        return @"28";
    }else if ([code isEqualToString:@"2816"]){
        return @"28";
    }else if ([code isEqualToString:@"2818"]){
        return @"28";
    }else if ([code isEqualToString:@"3610"]){
        return @"5";
    }else if ([code isEqualToString:@"3612"]){
        return @"5";
    }else if ([code isEqualToString:@"3616"]){
        return @"5";
    }else if ([code isEqualToString:@"3618"]){
        return @"5";
    }
    return 0;

}
+ (NSString*)Game36:(NSString *)name{
    if ([name isEqualToString:@"豹"]) {
    return @"5";
    } else if([name isEqualToString:@"顺"]){
      return @"7";
    }else if([name isEqualToString:@"对"]){
        return @"9";
    }else if([name isEqualToString:@"半"]){
        return @"11";
    }else {
        return @"13";
    }
    
}
@end
