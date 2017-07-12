//
//  UserModel.h
//  htbr
//
//  Created by somepark on 2017/4/25.
//  Copyright © 2017年 宋金杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject<NSCoding>
- (id)initWithDictionary:(id)dic;
/// 1：网上直销客户登录  2：代销渠道客户登录
@property (nonatomic,strong)NSString *pType;
//是否是哪一个点进的登陆界面
@property (nonatomic,strong) NSString * checkIndex;
/// 证件号码或者基金账号  加密
@property (nonatomic,strong)NSString *keyLN;
///交易密码 加密
@property (nonatomic,strong)NSString *keyTD;
///证件类型 基金账号：Z,身份证：0,中国护照:1，军官证：2,士兵证:3，出生证/户口本：5,其他:7
@property (nonatomic,strong)NSString *cerType;
///页面必须字段,登陆类型
@property (nonatomic,strong)NSString *logtype;
@end
