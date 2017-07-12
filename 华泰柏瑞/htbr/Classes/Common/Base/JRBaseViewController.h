//
//  JRBaseViewController.h
//  htbr
//
//  Created by aresoft on 15-4-7.
//  Copyright (c) 2015年 宋金杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JRBaseViewController : UIViewController
/**
 *  去掉导航栏下横线
 *
 *  @param view NavigationBar
 *
 *  @return ImageView
 */
@property (nonatomic, strong)UIImageView* navBarHairlineImageView;
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view;

@end
