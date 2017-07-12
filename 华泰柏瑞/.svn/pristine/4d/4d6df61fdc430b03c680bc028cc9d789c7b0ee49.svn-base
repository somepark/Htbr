//
//  JRHttpConnect.m
//  gla
//
//  Created by 高 阳 on 14-7-31.
//  Copyright (c) 2014年 aresoft. All rights reserved.
//

#import "JRHttpConnect.h"
#import "JSONKit.h"
#import "MKNetworkKit.h"
#import "ASIHTTPRequest.h"

@interface JRHttpConnect()

@property (nonatomic, copy) NSMutableString *responseJson;
@property (nonatomic, strong) MKNetworkEngine *engine;

@end

@implementation JRHttpConnect

+ (NSDictionary *)getUrl:(NSString *)urlString
{
    NSURL *requestUrl = [NSURL URLWithString:urlString];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:requestUrl];
    
    [request setTimeOutSeconds:40];
    
    request.delegate = self;
    
    // 显示网络请求信息在status bar上
    [ASIHTTPRequest setShouldUpdateNetworkActivityIndicator:YES];
    
    // 同步调用
    [request startSynchronous];
    
    //同步调用 获取结果
    NSError *error = [request error];
    
    if (!error) {
        // warning [request responseData]
        NSString *result = [request responseString];
        
        NSData *jsonData = [result dataUsingEncoding:NSUTF8StringEncoding];
        NSObject *object = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
        NSDictionary *dic = (NSDictionary *)object;
        
        return dic;
    }
    return nil;
}

@end
