//
//  UIView+Fixed.m
//  HuoNiu
//
//  Created by 高 阳 on 15/3/10.
//  Copyright (c) 2015年 高 阳. All rights reserved.
//

#import "UIView+Fixed.h"

@implementation UIView (Fixed)

CG_EXTERN CGRect CGFixedRect(CGRect frame)
{
    frame.origin.x = SWS(frame.origin.x);
    frame.origin.y = SHS(frame.origin.y);
    frame.size.width = SWS(frame.size.width);
    frame.size.height = SHS(frame.size.height);
    
    return frame;
}

CG_EXTERN CGRect CGFixedRectMake(CGFloat x, CGFloat y, CGFloat w, CGFloat h)
{
    CGFloat originX = SWS(x);
    originX = (int)(originX + 0.5f) > (int)originX ? (int)originX + 0.5 : (int)originX;
    CGFloat originY = SHS(y);
    originY = (int)(originY + 0.5f) > (int)originY ? (int)originY + 0.5 : (int)originY;
    CGFloat width = SWS(w);
    width = (int)(width + 0.5f) > (int)width ? (int)width + 0.5 : (int)width;
    CGFloat height = SHS(h);
    height = (int)(height + 0.5f) > (int)height ? (int)height + 0.5 : (int)height;

    return CGRectMake(originX, originY, width, height);
}

CG_EXTERN CGFloat CGFixedRectGetMaxX(CGRect frame)
{
    CGFloat maxX = CGRectGetMaxX(frame);
    
    return maxX * 320 / ScreenWidth;
}

CG_EXTERN CGFloat CGFixedRectGetMaxY(CGRect frame)
{
    CGFloat maxY = CGRectGetMaxY(frame);
    
    return maxY * 480 / ScreenHeight;
}

@end
