//
//  JRHtbrNavigationView.m
//  htbr
//
//  Created by aresoft on 15-4-7.
//  Copyright (c) 2015年 宋金杰. All rights reserved.
//

#import "JRHtbrNavigationView.h"
#import "JPUSHService.h"

#define pTypeString @"pType="

#define IS_IPHONE_4 (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double )480) < DBL_EPSILON )
#define IS_IPHONE_5 (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double )568) < DBL_EPSILON )
#define IS_IPHONE_6 (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double )667) < DBL_EPSILON )
#define IS_IPHONE_6_PLUS (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double )736) < DBL_EPSILON )

@interface JRHtbrNavigationView()<UIWebViewDelegate>
@property (nonatomic,strong) MBProgressHUD *hud;
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic,strong)UIImageView *imageView;

@end

@implementation JRHtbrNavigationView

- (id)initWithFrame:(CGRect)frame delegate:(id)delegate
{
    self = [super initWithFrame:frame];
    if (self) {
        //TODO customer inilization
        self.delegate = delegate;
        [self setStautsColor:[UIColor clearColor]];
        [self setBarContent];
        [self initViews];
    }
    return self;
}
- (void)setBarContent
{
    self.bar.hidden = YES;
}

- (void)initViews
{
    NSString *bgStr = @"";
    if (IS_IPHONE_4) {
        bgStr = @"bg640X960";
    }else if (IS_IPHONE_5){
        bgStr = @"bg640x1136";
    }else if (IS_IPHONE_6){
        bgStr = @"bg750x1334";
    }else if(IS_IPHONE_6_PLUS){
        bgStr = @"bg1242x2208";
    }
    _webView = [[UIWebView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    CGRect frame = self.webView.frame;
    frame.origin.y += 20;
    frame.size.height -= 20;
    self.webView.frame=frame;
    self.webView.scrollView.bounces = NO;
    self.webView.scalesPageToFit = YES;
    NSURL *url = [NSURL URLWithString:URL_PATH];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    self.webView.delegate = self;
    
    _webView.backgroundColor = [UIColor clearColor];
    _webView.opaque = NO;
    
    [self addSubview:self.webView];
    
//    UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
//    [self.webView addGestureRecognizer:recognizer];
    UISwipeGestureRecognizer *swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    [self.webView addGestureRecognizer:swipeRecognizer];
    self.webView.userInteractionEnabled = YES;
    
    //设置背景图片
    UIImage *image = [UIImage imageNamed:bgStr];
     _imageView= [[UIImageView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    _imageView.image = image;
    [self addSubview:_imageView];

}
-(void)loadLoginWebView{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",loginUrl,[[JRCommon unarchieveWithFile:UserInfoSavePath key:@"pType"] isEqualToString:@"1"]?@"PLoginZX.aspx":@"PLoginDX.aspx"]]];
    [self.webView loadRequest:request];
}
-(void)loadGestureSccessWebView{
    UserModel *userModel = [JRCommon currentUserMode:UserInfoSavePath];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@AppLoginLink.aspx?checkIndex=%@&keyLN=%@&keyTD=%@&cerType=%@&pType=%@&logtype=%@",CGEmpty(loginUrl),CGEmpty(userModel.checkIndex),CGEmpty(userModel.keyLN),CGEmpty(userModel.keyTD),CGEmpty(userModel.cerType),CGEmpty(userModel.pType),CGEmpty(userModel.logtype)]]];
    [self.webView loadRequest:request];
}
#pragma mark - SEL
- (void)buttonOnClick
{
    if (self.delegate) {
        [self.delegate goShares];
    }
}

- (void)swipe:(UISwipeGestureRecognizer *)recognizer
{
    if (recognizer.direction == UISwipeGestureRecognizerDirectionRight) {
        [self.webView goBack];
    }
}

- (void)handlePan:(UIPanGestureRecognizer *)recognizer
{
    CGFloat startPoint_X = 0.0;
    CGFloat endPoint_X;
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
        {
            startPoint_X = [recognizer locationInView:self.window].x;
            break;
        }
            
        case UIGestureRecognizerStateChanged:
        {
            endPoint_X = [recognizer locationInView:self.window].x;
            break;
        }
            
        case UIGestureRecognizerStateEnded:
        {
            endPoint_X = [recognizer locationInView:self.window].x;
            if (endPoint_X > startPoint_X) {
                //向右侧滑动
                UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"测试" message:@"应该返回" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alerView show];
                [self.webView goBack];
            }
            break;
        }
            
        case UIGestureRecognizerStateCancelled:
        {
            //手势取消
            NSLog(@"手势取消");
            UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"测试" message:@"手势取消" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alerView show];
            break;
        }
            
        case UIGestureRecognizerStateFailed:
        {
            //手势失败
            NSLog(@"手势失败");
            UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"测试" message:@"手势失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alerView show];
            break;
        }
            
        case UIGestureRecognizerStatePossible:
        {
            NSLog(@"手势可能");
            UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"测试" message:@"手势可能" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alerView show];
            break;
        }
    }
}

#pragma mark - UIWebViewDelegate
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{

    NSString *requestString = [[request URL] absoluteString];
    
    NSArray *components = [requestString componentsSeparatedByString:@":"];
    NSLog(@"%@",requestString);
    if ([components count] == 2 && [(NSString *)[components objectAtIndex:0] isEqualToString:@"toapp"]) {
        if([(NSString *)[components objectAtIndex:1] isEqualToString:@"goshare"])
        {
            [self buttonOnClick];
        }
        return NO;
    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"开始加载");
    //TODO 开始动画
    
    if (!_hud) {
        _hud= [MBProgressHUD showHUDAddedTo:self  animated:YES];
    }
    
    self.hud.mode = MBProgressHUDModeIndeterminate;
    self.hud.labelText = @"正在加载...";
    self.hud.margin = 10.f;
    self.hud.yOffset = 30.f;
   
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"加载完成");
    NSString *currentLoadingUrl= webView.request.URL.absoluteString;
    
    NSString * loginNoSuccess =[webView stringByEvaluatingJavaScriptFromString:@"loginNoSuccess()"];
    if([loginNoSuccess isEqualToString:@"false"]){
        if ([[NSUserDefaults standardUserDefaults]boolForKey:WHETHERCANLOGINGESTUREPASSWORD]) { //验证手势界面
            //跳转指定页面
            if ([currentLoadingUrl rangeOfString:@"checkIndex"].location!=NSNotFound) {
                //重新保存到缓存
                UserModel * uModel = [JRCommon currentUserMode:UserInfoSavePath];
                NSDictionary *checkIndexDic = [self getURLParameters:currentLoadingUrl];
                uModel.checkIndex = checkIndexDic[@"checkIndex"];
                [JRCommon archieveWithData:uModel toFile:UserInfoSavePath];
            };
            if (self.whetherSetGestureBlock) {
                //验证手势界面
                self.whetherSetGestureBlock(NO);
            }
        }
    }else if([loginNoSuccess isEqualToString:@"true"]){ //手势界面点击其他按钮登陆
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:WHETHERCANLOGINGESTUREPASSWORD];
    }else if ([currentLoadingUrl rangeOfString:pTypeString].location!=NSNotFound) { //设置手势密码
        if (![[NSUserDefaults standardUserDefaults] boolForKey:WHETHERCANLOGINGESTUREPASSWORD]) {
            //截取带参数的字符串
            NSDictionary *dic = [self getURLParameters:currentLoadingUrl];
            //缓存数据
            UserModel *userModel = [[UserModel alloc]initWithDictionary:dic];
            [JRCommon archieveWithData:userModel toFile:UserInfoSavePath];
            
            //是否设置手势密码
            if (_whetherSetGestureBlock) {
                _whetherSetGestureBlock(YES);
            }
        }
    }else if ([currentLoadingUrl rangeOfString:@"/query/query_xgmm.aspx"].location !=NSNotFound) {  //修改密码
            NSString *newPwd= [webView stringByEvaluatingJavaScriptFromString:@"newKeyTD()"];
            if (newPwd.length>1) {
                UserModel * uModel = [JRCommon currentUserMode:UserInfoSavePath];
                uModel.keyTD = newPwd;
                //重新保存到缓存
                [JRCommon archieveWithData:uModel toFile:UserInfoSavePath];
            }
        }
    
    //第一次进入h5页面
    if([currentLoadingUrl rangeOfString:URL_PATH].location != NSNotFound){
        [self setStautsColor:[UIColor statusBackgroundColor]];
        [_imageView removeFromSuperview];
        _imageView = nil;
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    }
    
    
    //TODO url加载完成后结束动画
    self.hud.removeFromSuperViewOnHide = YES;
    [self.hud hide:YES];
    self.hud = nil;
    
    [webView stringByEvaluatingJavaScriptFromString:@"window.oc_objc = 'inapp';"];
}
-(void)goback{
    [self.webView goBack];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    self.hud.removeFromSuperViewOnHide = YES;
    [self.hud hide:YES];
    self.hud = nil;
    NSLog(@"失败");
}
/**
 *  截取URL中的参数
 *
 *  @return NSMutableDictionary parameters
 */
- (NSMutableDictionary *)getURLParameters:(NSString *)urlString{
    
    // 查找参数
    NSRange range = [urlString rangeOfString:@"?"];
    if (range.location == NSNotFound) {
        return nil;
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    // 截取参数
    NSString *parametersString = [urlString substringFromIndex:range.location + 1];
    
    // 判断参数是单个参数还是多个参数
    if ([parametersString containsString:@"&"]) {
        
        // 多个参数，分割参数
        NSArray *urlComponents = [parametersString componentsSeparatedByString:@"&"];
        
        for (NSString *keyValuePair in urlComponents) {
            // 生成Key/Value
            NSArray *pairComponents = [keyValuePair componentsSeparatedByString:@"="];
            NSString *key = [pairComponents.firstObject stringByRemovingPercentEncoding];
            NSString *value = [pairComponents.lastObject stringByRemovingPercentEncoding];
            
            // Key不能为nil
            if (key == nil || value == nil) {
                continue;
            }
            
            id existValue = [params valueForKey:key];
            
            if (existValue != nil) {
                
                // 已存在的值，生成数组
                if ([existValue isKindOfClass:[NSArray class]]) {
                    // 已存在的值生成数组
                    NSMutableArray *items = [NSMutableArray arrayWithArray:existValue];
                    [items addObject:value];
                    
                    [params setValue:items forKey:key];
                } else {
                    
                    // 非数组
                    [params setValue:@[existValue, value] forKey:key];
                }
                
            } else {
                
                // 设置值
                [params setValue:value forKey:key];
            }
        }
    } else {
        // 单个参数
        
        // 生成Key/Value
        NSArray *pairComponents = [parametersString componentsSeparatedByString:@"="];
        
        // 只有一个参数，没有值
        if (pairComponents.count == 1) {
            return nil;
        }
        
        // 分隔值
        NSString *key = [pairComponents.firstObject stringByRemovingPercentEncoding];
        NSString *value = [pairComponents.lastObject stringByRemovingPercentEncoding];
        
        // Key不能为nil
        if (key == nil || value == nil) {
            return nil;
        }
        
        // 设置值
        [params setValue:value forKey:key];
    }
    
    return params;
}

@end
