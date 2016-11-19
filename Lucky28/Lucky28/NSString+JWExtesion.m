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

//+ (NSString *)CodeForType:(NSInteger *)code{
//    
//    
//}
@end
