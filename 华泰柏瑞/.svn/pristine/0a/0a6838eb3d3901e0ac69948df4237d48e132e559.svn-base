//
//  JRHttpConnect.h
//  gla
//
//  Created by 高 阳 on 14-7-31.
//  Copyright (c) 2014年 aresoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JRHttpConnect;
@protocol JRHttpConnectDelegate <NSObject>

@end

@interface JRHttpConnect : NSObject<NSXMLParserDelegate>

@property (nonatomic, assign) id<JRHttpConnectDelegate> delegate;

+ (NSDictionary *)getUrl:(NSString *)urlString;

@end
