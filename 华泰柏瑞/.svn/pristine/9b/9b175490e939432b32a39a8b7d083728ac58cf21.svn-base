//
//  JRHtbrNavigationViewController.m
//  htbr
//
//  Created by aresoft on 15-4-7.
//  Copyright (c) 2015年 宋金杰. All rights reserved.
//

#import "JRHtbrNavigationViewController.h"
#import "JRHtbrNavigationView.h"
#import <UMMobClick/MobClick.h>
#import "JRHtbrSharesViewController.h"
#import "GestureViewController.h"
@interface JRHtbrNavigationViewController ()<JRHtbrNavigationViewDelegate, UIAlertViewDelegate,GestureViewControllerDelegate>

@property (nonatomic, strong) JRHtbrNavigationView *htbrNavigationView;
@property(nonatomic, strong)JRHtbrSharesViewController *shareView;

@end

@implementation JRHtbrNavigationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //TODO customer inilization
        
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    _htbrNavigationView = [[JRHtbrNavigationView alloc] initWithFrame:self.view.bounds delegate:self];
    [self.view addSubview:self.htbrNavigationView];
    __weak __typeof__(self) weakSelf = self;
    _htbrNavigationView.whetherSetGestureBlock =^(BOOL whtherSetPassword){
        __strong __typeof__(weakSelf) strongSelf = weakSelf;

        if (whtherSetPassword) {
            //开启手势密码
            GestureViewController *gestureVc = [[GestureViewController alloc] init];
            gestureVc.delegate= strongSelf;
            gestureVc.type = GestureViewControllerTypeSetting;
            [strongSelf.navigationController pushViewController:gestureVc animated:NO];
        }else{
           GestureViewController* gestureViewController = [[GestureViewController alloc] init];
            gestureViewController.delegate = strongSelf;
            gestureViewController.type = GestureViewControllerTypeLogin;
            [strongSelf.navigationController pushViewController:gestureViewController animated:NO];
        }
    };
}
#pragma mark gesturePasswordView - delegate
-(void)forgetPasswordForGesuture{
    [self.htbrNavigationView loadLoginWebView];
}
-(void)loginOtherViewForGesture{
    [self.htbrNavigationView loadLoginWebView];
}
//手势密码登陆成功
-(void)gesturePasswordLoginSuccess{
    //登陆成功传值
    [_htbrNavigationView loadGestureSccessWebView];
}
//登陆次数达到限制，直接跳转到登陆界面
-(void)skipToLoginView{
    [self.htbrNavigationView loadLoginWebView];
}
//验证手势点击返回按钮啊讴
-(void)gestureLoginViewWithBack{
    [_htbrNavigationView goback];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    BOOL needUpdate = [JRCommon checkNewVersion];
    if (needUpdate) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"更新提示" message:[JRCommon releaseNotes] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"更新", nil];
        [alert show];
    }
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:APP_DOWNLOAD_URL]];
    }
}

#pragma mark - JRHtbrNavigationViewDelegate
- (void)goShares
{
    _shareView = [[JRHtbrSharesViewController alloc]init];
    [self.navigationController pushViewController:self.shareView animated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [MobClick beginLogPageView:@"首页"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"首页"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
