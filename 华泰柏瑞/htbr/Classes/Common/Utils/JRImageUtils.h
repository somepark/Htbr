//
//  JRImageUtils.h
//  gla
//
//  Created by 高 阳 on 14-7-29.
//  Copyright (c) 2014年 aresoft. All rights reserved.
//

#import <Foundation/Foundation.h>

//FOR: imageWithColor:(UIColor *) cornerRadius:(CGFloat)
#define DEFAULT_IAMGE_SPACE     1

@interface JRImageUtils : NSObject

/* 生成纯色的图片 */
+ (UIImage *)imageWithColor:(UIColor *)color cornerRadius:(CGFloat)cornerRadius;

@end
