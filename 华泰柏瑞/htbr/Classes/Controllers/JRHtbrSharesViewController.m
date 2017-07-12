//
//  JRHtbrSharesViewController.m
//  htbr
//
//  Created by aresoft on 15-4-8.
//  Copyright (c) 2015年 宋金杰. All rights reserved.
//

#import "JRHtbrSharesViewController.h"
#import "JRHtbrSharesView.h"
#import "UMSocial.h"
#import <UMMobClick/MobClick.h>

@interface JRHtbrSharesViewController ()<JRHtbrSharesViewDelegate,UMSocialUIDelegate>

@property (nonatomic, copy) JRHtbrSharesView *sharesView;

@end

@implementation JRHtbrSharesViewController

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
    _sharesView = [[JRHtbrSharesView alloc] initWithFrame:self.view.bounds delegate:self];
    [self.view addSubview:self.sharesView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"分享"];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"分享"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - JRHtbrSharesViewDelegate
- (void)buttonOnClickAtIndex:(NSInteger)index
{
    switch (index) {
        case TAG_BUTTON_WEIXIN:
        {
            [[UMSocialDataService defaultDataService] postSNSWithTypes:[[NSArray alloc] initWithObjects:UMShareToWechatSession, nil] content:@"华泰博瑞" image:nil location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response) {

            }];
            break;
        }
        case TAG_BUTTON_PENGYOUQUAN:
        {
            [[UMSocialDataService defaultDataService]postSNSWithTypes:@[UMShareToWechatTimeline] content:@"华泰博瑞" image: nil location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response) {
                if (response.responseCode == UMSResponseCodeSuccess) {

                }
            }];
            break;
        }
        case TAG_BUTTON_WEIBO:
        {
            [[UMSocialControllerService defaultControllerService] setShareText:@"华泰博瑞 " shareImage:nil socialUIDelegate:self];
            
            [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina].snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
            break;
        }
        case TAG_BUTTON_QQ:
        {
            [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToQQ] content:@"华泰博瑞" image:nil location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
                if (response.responseCode == UMSResponseCodeSuccess) {

                }
            }];
            
            break;
        }
        case TAG_BUTTON_KONGJIAN:
        {
            [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToQzone] content:@"华泰博瑞" image:nil location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
                if (response.responseCode == UMSResponseCodeSuccess) {

                }
            }];
            break;
        }
    }
}

#pragma mark - JRHtbrSharesViewDelegate
- (void)goBack
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
