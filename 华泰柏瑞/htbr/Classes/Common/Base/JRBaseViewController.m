//
//  JRBaseViewController.m
//  htbr
//
//  Created by aresoft on 15-4-7.
//  Copyright (c) 2015年 宋金杰. All rights reserved.
//

#import "JRBaseViewController.h"

@interface JRBaseViewController ()

@end

@implementation JRBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)loadView
{
    UIView *baseView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    baseView.backgroundColor = [UIColor backgroundColor];
    self.view = baseView;
    
    self.navigationController.navigationBarHidden = YES;
    
//    if ([JRCommon isIOS7]) {
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
}
-(void)remoteNotification:(NSNotification *)notif{
    if ([notif.name isEqualToString:kApplicationDidReceieveRemoteNotification]&&[notif.userInfo[@"state"] isEqual:@(0)]) {
        NSString *message = notif.userInfo[@"aps"][@"alert"];
        if ([message isKindOfClass:[NSString class]]) {
            UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"推送消息" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        return;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController.navigationBar setBarTintColor:RGBCOLOR(35, 36, 40)];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:
  @{NSFontAttributeName:[UIFont systemFontOfSize:16],
    NSForegroundColorAttributeName:[UIColor whiteColor]}];

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(remoteNotification:) name:kApplicationDidReceieveRemoteNotification object:nil];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kApplicationDidReceieveRemoteNotification object:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  去掉导航栏的横线
 */
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}
@end
