//
//  JRHtbrNavigationView.h
//  htbr
//
//  Created by aresoft on 15-4-7.
//  Copyright (c) 2015年 宋金杰. All rights reserved.
//

#import "JRBaseBarView.h"
#import "MBProgressHUD.h"
#import <JavaScriptCore/JavaScriptCore.h>

typedef void (^whetherSetGestureBlock)(BOOL whetherSetGesturePassWord);//no:验证手势密码，yes:设置手势密码

@protocol JRHtbrNavigationViewDelegate <NSObject>

- (void)goShares;

@end
@interface JRHtbrNavigationView : JRBaseBarView
@property (nonatomic,copy)whetherSetGestureBlock whetherSetGestureBlock;

@property (nonatomic, assign) id<JRHtbrNavigationViewDelegate>delegate;

- (id)initWithFrame:(CGRect)frame delegate:(id)delegate;
//加载登陆界面
-(void)loadLoginWebView;
//手势密码验证通过直接加载登陆过后的界面
-(void)loadGestureSccessWebView;
-(void)goback;
@end
