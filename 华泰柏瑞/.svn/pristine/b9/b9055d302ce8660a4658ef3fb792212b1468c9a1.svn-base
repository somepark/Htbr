//
//  JRBaseBarView.h
//  gla
//
//  Created by 高 阳 on 14-7-29.
//  Copyright (c) 2014年 aresoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JRUIBar.h"
#import "JRHomeBar.h"

@interface JRBaseBarView : UIView<JRBarDelegate>

@property (nonatomic, readonly) JRUIBar *bar;
@property (nonatomic, readonly) JRHomeBar *homeBar;
@property (nonatomic, readonly) UIView *contentView;
@property (nonatomic, readonly) UIScrollView *containerView;

- (void)resetHomeBar;
//设置状态栏的颜色
- (void)setStautsColor:(UIColor *)color;

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;

- (CGRect)CGRectMakeFixed:(CGRect) frame;
- (CGFloat)CGRectGetMaxXFixed:(CGRect)frame;
- (CGFloat)CGRectGetMaxYFixed:(CGRect)frame;

@end
