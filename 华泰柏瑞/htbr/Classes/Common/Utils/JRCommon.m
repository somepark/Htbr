//
//  JRCommon.m
//  gla
//
//  Created by 高 阳 on 14-7-28.
//  Copyright (c) 2014年 aresoft. All rights reserved.
//

#import "JRCommon.h"

@implementation JRCommon

+(NSString *)deviceVersion
{
    UIDevice *device = [UIDevice currentDevice];
    return device.systemVersion;
}

+ (NSString *)appVersion
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    return version;
}

+ (BOOL)isIOS7
{
    double version = [[UIDevice currentDevice].systemVersion doubleValue];
    return version >= 7.0;
}

+ (BOOL)isShortDisplay
{
    return [[UIScreen mainScreen] applicationFrame].size.height <= 480;
}

+ (NSString *)getBundleDisplayName
{
    NSDictionary *infoDIct = [[NSBundle mainBundle] infoDictionary];
    NSString *appName = [infoDIct objectForKeyedSubscript:@"CFBundleDisplayName"];
    return appName;
}

+ (NSString *)phoneID
{
    NSUUID *uuid = [[UIDevice currentDevice] identifierForVendor];
    NSString *phoneID = [uuid UUIDString];
    return phoneID;
}

+ (BOOL)checkNewVersion
{
    //判断是否更新
    NSDictionary *dic = [JRHttpConnect getUrl:URL_CHECK_VERSION];
    [self resolveVersionInfo:dic];
    return [self checkUpdate];
}

#pragma mark - reslove version info
+ (void)resolveVersionInfo:(NSDictionary *)dic
{
    NSArray *resultArray = [dic objectForKey:@"results"];
    if (resultArray == nil || [resultArray count] == 0) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults removeObjectForKey:NSNOTIFICATION_SERVER_VERSION];
        [defaults removeObjectForKey:NSNOTIFICATION_UPDATE_INFO];
        [defaults synchronize];
        return;
    }
    
    NSDictionary *verDic = [resultArray objectAtIndex:0];
    NSString *version = [verDic objectForKey:@"version"];
    NSString *releaseNotes = [verDic objectForKey:@"releaseNotes"];
    
    //简单处理,直接保存在NSUserDefault里,HtfMainViewController判断，更新
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:version forKey:NSNOTIFICATION_SERVER_VERSION];
    [defaults setObject:releaseNotes forKey:NSNOTIFICATION_UPDATE_INFO];
    
    [defaults synchronize];
    
}

+ (BOOL)checkUpdate
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *serverVer = [defaults objectForKey:NSNOTIFICATION_SERVER_VERSION];
    NSString *clientVer = [NSString stringWithFormat:@"%@", [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey]];
    
    NSArray *serverVersionArr = [serverVer componentsSeparatedByString:@"."];
    NSArray *clientVersionArr = [clientVer componentsSeparatedByString:@"."];
    
    BOOL needUpdate = false;
    int versionArrLen = (int)MAX([serverVersionArr count], [clientVersionArr count]);
    
    for (int i = 0; i < versionArrLen; i ++) {
        NSString *serverItem = @"0";
        
        NSString *clientItem = @"0";
        
        if(i < [clientVersionArr count]) {
            clientItem = [clientVersionArr objectAtIndex:i];
        }
        
        if (i < [serverVersionArr count]) {
            serverItem = [serverVersionArr objectAtIndex:i];
        }
        
        //1.0.1  1.5
        if ([serverItem floatValue] == [clientItem floatValue]) {
            //版本第i位相同，进行下一位的判定
            continue;
        } else if ([serverItem floatValue] < [clientItem floatValue]) {
            needUpdate = NO;
            break;
            
        } else if ([serverItem floatValue] > [clientItem floatValue]) {
            needUpdate = YES;
            break;
        }
    }
    
    return needUpdate;
}

+ (NSString *)releaseNotes
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:NSNOTIFICATION_UPDATE_INFO] ? [defaults objectForKey:NSNOTIFICATION_UPDATE_INFO] : @"有新的版本，是否更新？";
}

/**
 数据的归档解档
 */
+(BOOL)archieveWithData:(id)data toFile:(NSString *)file{
    
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES).lastObject;
    NSString *filePath = [path stringByAppendingPathComponent:file];
    
    BOOL success = [NSKeyedArchiver archiveRootObject:data toFile:filePath];
    if (!success) {
        NSLog(@"归档失败");
    }
    return success;
}

+(id)unarchieveWithFile:(NSString *)file key:(NSString *)key{
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:file];
    
    UserModel *model = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    id object = [model valueForKey:key];
    return object;
}
+(UserModel *)currentUserMode:(NSString *)path{
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:path];
    UserModel *model = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    return model;
}

@end
