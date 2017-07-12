//
//  JRHomeBar.m
//  gla
//
//  Created by 高 阳 on 14-8-25.
//  Copyright (c) 2014年 高 阳. All rights reserved.
//

#import "JRHomeBar.h"
#import "JRImageUtils.h"

#define LOGO_MARGIN_LEFT        10
#define LOGO_HEIGHT             23.5
#define LOGO_WIDTH              121

@interface JRHomeBar()

//用于显示用户的姓名
@property (nonatomic, strong) UILabel *customNameLabel;

@end

@implementation JRHomeBar

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
    [bgImageView setImage:[[JRImageUtils imageWithColor:RGBCOLOR(13, 70, 157) cornerRadius:0] stretchableImageWithLeftCapWidth:0 topCapHeight:0]];
    [self addSubview:bgImageView];
    
    CGFloat originX = LOGO_MARGIN_LEFT;
    UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(originX, (TAB_BAR_HEIGHT - LOGO_HEIGHT) / 2.0f, LOGO_WIDTH, LOGO_HEIGHT)];
    [iconImageView setImage:[UIImage imageNamed:@"top_logo"]];
    [self addSubview:iconImageView];
    
    _customNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 315, TAB_BAR_HEIGHT)];
    self.customNameLabel.backgroundColor = [UIColor clearColor];
    self.customNameLabel.textColor = [UIColor whiteColor];
    self.customNameLabel.font = [UIFont fontOfSize:17.5];
    [self.customNameLabel setTextAlignment:NSTextAlignmentRight];
    [self addSubview:self.customNameLabel];
}

- (void)setCustomName:(NSString *)customName
{
    self.customNameLabel.text = customName;
}

@end
