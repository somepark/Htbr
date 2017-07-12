//
//  JRUIBar.h
//  gla
//
//  Created by 高 阳 on 14-7-29.
//  Copyright (c) 2014年 aresoft. All rights reserved.
//

#import <UIKit/UIKit.h>

#define BAR_H               37
#define BAR_STAUTS_HEIGHT   64

@class JRUIBar;
@protocol JRBarDelegate <NSObject>

@optional
- (void)uiBar:(JRUIBar *)bar leftButtonClick:(UIButton *)button;
- (void)uiBar:(JRUIBar *)bar rightButtonClick:(UIButton *)button;
@end

@interface JRUIBar : UIView

@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UILabel  *titleLabel;
@property (nonatomic, strong) UIButton *rightButton;

@property (nonatomic, assign) id<JRBarDelegate> delegate;

/* 设置标题 */
- (void)setTitle:(NSString *)title;
/* 设置标题,及NSTextAlignment */
- (void)title:(NSString *)title textAlignment:(NSTextAlignment)alignment;

/* 设置按钮的图片 */
- (void)button:(UIButton *)button setRightButtonNormalImage:(NSString *)normalImage highlightedImage:(NSString *)highlightImage selectedImage:(NSString *)selectedImage;

/* 移除按钮 */
- (void)removeButton:(UIButton *)button;
- (void)createRightButton:(BOOL)show;

@end
