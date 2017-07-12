//
//  JRHtbrSharesView.h
//  htbr
//
//  Created by aresoft on 15-4-8.
//  Copyright (c) 2015年 宋金杰. All rights reserved.
//

#import "JRBaseBarView.h"

#define TAG_BUTTON_WEIXIN           101 //微信
#define TAG_BUTTON_PENGYOUQUAN      102 //朋友圈
#define TAG_BUTTON_WEIBO            103 //微博
#define TAG_BUTTON_QQ               104 //qq好友
#define TAG_BUTTON_KONGJIAN         105 //空间

@protocol JRHtbrSharesViewDelegate <NSObject>

- (void)goBack;
- (void)buttonOnClickAtIndex:(NSInteger)index;

@end

@interface JRHtbrSharesView : JRBaseBarView

@property (nonatomic, assign) id<JRHtbrSharesViewDelegate>delegate;

- (id)initWithFrame:(CGRect)frame delegate:(id)delegate;

@end
