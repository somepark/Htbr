//
//  JRUIBar.m
//  gla
//
//  Created by 高 阳 on 14-7-29.
//  Copyright (c) 2014年 aresoft. All rights reserved.
//

#import "JRUIBar.h"
#import "JRImageUtils.h"

#define BUTTON_W            23.5
#define BUTTON_H            38
#define TITLE_MARGIN_LEFT   0


@interface JRUIBar()


@end

@implementation JRUIBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
    }
    return self;
}

/* 初始化view */
- (void)initViews
{
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    [bgImageView setImage:[[JRImageUtils imageWithColor:[UIColor navigationColor] cornerRadius:0] stretchableImageWithLeftCapWidth:0 topCapHeight:0]];
    [self addSubview:bgImageView];
    
    self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftButton.frame = CGRectMake(0, 0, BUTTON_W, CGRectGetHeight(self.bounds));
    [self.leftButton setImage:[UIImage imageNamed:@"bar_back_normal"] forState:UIControlStateNormal];
    [self.leftButton setImage:[UIImage imageNamed:@"bar_back_highlighted"] forState:UIControlStateHighlighted];
    [self.leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.leftButton setContentMode:UIViewContentModeCenter];
    [self addSubview:self.leftButton];
    
    self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightButton.frame = CGRectMake(CGRectGetMaxX(self.frame) - BUTTON_W - 12, 0, BUTTON_W, CGRectGetHeight(self.bounds));
    [self.rightButton.titleLabel setFont:[UIFont boldSystemFontOfSize:NORMAL_TEXT_SIZE_MAX]];
    [self.rightButton.titleLabel setTextColor:[UIColor whiteColor]];
    
    [self.rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightButton setContentMode:UIViewContentModeCenter];
    self.rightButton.hidden = YES;
    [self addSubview:self.rightButton];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(BUTTON_W + TITLE_MARGIN_LEFT, 0, CGRectGetWidth(self.bounds) - 2 * BUTTON_W - TITLE_MARGIN_LEFT, CGRectGetHeight(self.bounds))];
    [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.titleLabel setBackgroundColor:[UIColor clearColor]];
    [self.titleLabel setFont:[UIFont boldSystemFontOfSize:NORMAL_TEXT_SIZE_MAX]];
    [self.titleLabel setTextColor:[UIColor whiteColor]];
    [self addSubview:self.titleLabel];
}

#pragma mark - buttons
- (void)button:(UIButton *)button setRightButtonNormalImage:(NSString *)normalImage highlightedImage:(NSString *)highlightImage selectedImage:(NSString *)selectedImage
{
    [button setBackgroundImage:[UIImage imageNamed:normalImage] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highlightImage] forState:UIControlStateHighlighted];
    [button setBackgroundImage:[UIImage imageNamed:selectedImage] forState:UIControlStateSelected];
}

- (void)removeButton:(UIButton *)button
{
    [button removeFromSuperview];
    button = nil;
}

- (void)createRightButton:(BOOL)show
{
    if (self.rightButton) {
        [self removeButton:self.rightButton];
    }
    
    self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightButton.frame = CGRectMake(CGRectGetMaxX(self.frame) - BUTTON_W, 0, BUTTON_W, CGRectGetHeight(self.bounds));
    [self.rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightButton setContentMode:UIViewContentModeCenter];
    self.rightButton.hidden = !show;
    [self addSubview:self.rightButton];
}

#pragma mark - button click
- (void)leftButtonClick:(UIButton *)button
{
    if (self.delegate) {
        [self.delegate uiBar:self leftButtonClick:button];
    }
}

- (void)rightButtonClick:(UIButton *)button
{
    if (self.delegate) {
        [self.delegate uiBar:self rightButtonClick:button];
    }
}


#pragma mark - title
- (void)setTitle:(NSString *)title
{
    [self.titleLabel setText:title];
}

- (void)title:(NSString *)title textAlignment:(NSTextAlignment)alignment
{
    [self.titleLabel setText:title];
    [self.titleLabel setTextAlignment:alignment];
}

@end
