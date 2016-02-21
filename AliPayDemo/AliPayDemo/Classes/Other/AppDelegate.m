//
//  AppDelegate.m
//  AliPayDemo
//
//  Created by 余亮 on 16/2/21.
//  Copyright © 2016年 余亮. All rights reserved.
//

#import "AppDelegate.h"
#import <AlipaySDK/AlipaySDK.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}

/**
  当通过别的应用程序，将支付宝客户端打开时，会调用该方法
 */
- (BOOL) application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options
{
  
    NSLog(@"%@",url);  //url为支付宝客户端支付后的支付结果
    //当用户通过支付宝客户端支付时，会回调该block:standbyCallback
    [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
        NSLog(@"%@",resultDic);
    }];
    return YES;
}


@end
