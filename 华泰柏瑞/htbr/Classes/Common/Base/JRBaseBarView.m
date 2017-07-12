//
//  JRBaseBarView.m
//  gla
//
//  Created by 高 阳 on 14-7-29.
//  Copyright (c) 2014年 aresoft. All rights reserved.
//

#import "JRBaseBarView.h"

@interface JRBaseBarView()

@property (nonatomic, strong) UIView *stautsView;

@end

@implementation JRBaseBarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initBaseViews];
        
        if([JRCommon isIOS7]) {
            CGRect frame = self.contentView.frame;
            frame.size.height += 20;
            self.contentView.frame = frame;
        }
        
        self.containerView.frame = self.contentView.bounds;
    }
    return self;
}

/* 初始化view */
- (void)initBaseViews
{
    CGFloat originY = 0;
    
    if ([JRCommon isIOS7]) {
        
        _stautsView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 20)];
        [self.stautsView setBackgroundColor:[UIColor statusBackgroundColor]];
        [self addSubview:self.stautsView];
        [self sendSubviewToBack:self.stautsView];
        
        originY = 20;
    }
    
    _bar = [[JRUIBar alloc] initWithFrame:CGRectMake(0, originY, CGRectGetWidth(self.frame), BAR_H)];
    self.bar.delegate = self;
    [self addSubview:self.bar];
    
    originY += BAR_H;
    _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, originY, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - originY)];
    [self addSubview:self.contentView];
    [self sendSubviewToBack:self.contentView];
    
    
    originY = TOP_VIEW_HEIGHT;
    _containerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, originY, CGRectGetWidth(self.contentView.frame), CGRectGetHeight(self.contentView.frame) - originY)];
    [self.containerView setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:self.containerView];
    [self.contentView sendSubviewToBack:self.containerView];
}

- (void)resetHomeBar
{
    [_bar removeFromSuperview];
    _bar = nil;
    
    CGFloat originY = 0;
    if ([JRCommon isIOS7]) {
        originY = 20;
    }
    _homeBar = [[JRHomeBar alloc] initWithFrame:CGRectMake(0, originY, CGRectGetWidth(self.frame), BAR_H)];
    [self addSubview:self.homeBar];
}

- (void)setStautsColor:(UIColor *)color
{
    self.stautsView.backgroundColor = color;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    return YES;
}


@end
