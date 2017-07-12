//
//  JRCommon.h
//  gla
//
//  Created by 高 阳 on 14-7-28.
//  Copyright (c) 2014年 aresoft. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UserModel;
@interface JRCommon : NSObject

//获取设备版本号
+ (NSString *)deviceVersion;

//获取当前app版本号
+ (NSString *)appVersion;

//判断设置版本号是否是ios7+
+ (BOOL)isIOS7;

+ (BOOL)isShortDisplay;

//获取设备编号
+ (NSString *)phoneID;

//查看是否需要更新app
+ (BOOL)checkNewVersion;

/**
 获取更新信息
 */
+ (NSString *)releaseNotes;


/**
 数据的归档解档
 */
+(BOOL)archieveWithData:(id)data toFile:(NSString *)file;
+(id)unarchieveWithFile:(NSString *)file key:(NSString *)key;
+(UserModel *)currentUserMode:(NSString *)path;

@end
