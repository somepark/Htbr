//
//  JRHtbrSharesView.m
//  htbr
//
//  Created by aresoft on 15-4-8.
//  Copyright (c) 2015年 宋金杰. All rights reserved.
//

#import "JRHtbrSharesView.h"

#define MARGIN_TOP              17.5
#define MARGIN_LEFT             25
#define MARGIN_RIGHT            26
#define PADDING_TOP             14
#define BUTTON_HEIGHT           58

@implementation JRHtbrSharesView

- (id)initWithFrame:(CGRect)frame delegate:(id)delegate
{
    self = [super initWithFrame:frame];
    if (self) {
        //TODO customer inilization
        self.delegate = delegate;
        [self setBarContent];
        [self initViews];
    }
    return self;
}

- (void)setBarContent
{
    [self.bar setTitle:@"分享"];

}

- (void)initViews
{
    CGFloat originX = MARGIN_LEFT;
    CGFloat originY = MARGIN_TOP;
    CGFloat width = self.frame.size.width - MARGIN_LEFT - MARGIN_RIGHT;
    
    [self.containerView addSubview:[self viewWithOriginX:originX originY:originY width:width height:BUTTON_HEIGHT bgColor:[UIColor lightGreenColor] rightColor:[UIColor lightGreenColor1] title:@"分享给微信好友" image:[UIImage imageNamed:@"weixin"] tag:TAG_BUTTON_WEIXIN]];
    
    [self.containerView addSubview:[self viewWithOriginX:originX originY:originY+BUTTON_HEIGHT+PADDING_TOP width:width height:BUTTON_HEIGHT bgColor:[UIColor deepGreenColor] rightColor:[UIColor deepGreenColor1] title:@"分享到朋友圈" image:[UIImage imageNamed:@"pengyouquan"] tag:TAG_BUTTON_PENGYOUQUAN]];
    
    [self.containerView addSubview:[self viewWithOriginX:originX originY:originY+(BUTTON_HEIGHT+PADDING_TOP)*2 width:width height:BUTTON_HEIGHT bgColor:[UIColor lightRedColor] rightColor:[UIColor lightRedColor1] title:@"分享到微博" image:[UIImage imageNamed:@"weibo"] tag:TAG_BUTTON_WEIBO]];
    
    [self.containerView addSubview:[self viewWithOriginX:originX originY:originY+(BUTTON_HEIGHT+PADDING_TOP)*3 width:width height:BUTTON_HEIGHT bgColor:[UIColor lightBuleColor] rightColor:[UIColor lightBuleColor1] title:@"分享给QQ好友" image:[UIImage imageNamed:@"qq"] tag:TAG_BUTTON_QQ]];
    
    [self.containerView addSubview:[self viewWithOriginX:originX originY:originY+(BUTTON_HEIGHT+PADDING_TOP)*4 width:width height:BUTTON_HEIGHT bgColor:[UIColor lightYellowColor] rightColor:[UIColor lightYellowColor1] title:@"分享到空间" image:[UIImage imageNamed:@"kongjian"] tag:TAG_BUTTON_KONGJIAN]];
    
}

#pragma mark - 视图控制
- (UIView *)viewWithOriginX:(CGFloat)originX originY:(CGFloat)originY width:(CGFloat)width height:(CGFloat)height bgColor:(UIColor *)bgColor rightColor:(UIColor*)rightColor title:(NSString *)title image:(UIImage *)image tag:(NSInteger)tag
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(originX, originY, width, height)];
    bgView.layer.cornerRadius = 2;
    bgView.backgroundColor = bgColor;
    
    //头部label
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 14, width - 10, height - 14*2)];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.font = [UIFont fontOfSize:20];
    titleLabel.text = title;
    [bgView addSubview:titleLabel];
    
    //右侧图像
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(width - height, 0, height, height)];
    imageView.backgroundColor = rightColor;
    [bgView addSubview:imageView];
    
    UIButton *imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    imageButton.frame = imageView.bounds;
    [imageButton setImage:image forState:UIControlStateNormal];
    [imageView addSubview:imageButton];
    
    //覆盖按钮
    UIButton *fullButton = [UIButton buttonWithType:UIButtonTypeCustom];
    fullButton.frame = bgView.bounds;
    fullButton.tag = tag;
    [fullButton addTarget:self action:@selector(buttonOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:fullButton];
    
    return bgView;
}

#pragma mark - SEL
- (void)buttonOnClick:(UIButton *)button
{
    if (self.delegate) {
        [self.delegate buttonOnClickAtIndex:button.tag];
    }
}

#pragma mark - JRUIBarDelegate
- (void)uiBar:(JRUIBar *)bar leftButtonClick:(UIButton *)button
{
    if (self.delegate) {
        [self.delegate goBack];
    }
}

@end
