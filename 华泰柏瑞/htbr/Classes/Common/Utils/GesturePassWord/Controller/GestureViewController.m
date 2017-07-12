
#import "GestureViewController.h"
#import "PCCircleView.h"
#import "PCCircleViewConst.h"
#import "PCLockLabel.h"
#import "PCCircleInfoView.h"
#import "PCCircle.h"
#import "UIViewController+BackButtonHandler.h"
static int residueDegree = NumberOfGestureLockVerifications;//可验证次数


@interface GestureViewController ()<CircleViewDelegate,BackButtonHandlerProtocol>

/**
 *  重设按钮
 */
@property (nonatomic, strong) UIButton *resetBtn;
/**
 *  提示Label
 */
@property (nonatomic, strong) PCLockLabel *msgLabel;
@property (nonatomic, strong) PCLockLabel *msgLabel2;

/**
 *  解锁界面
 */
@property (nonatomic, strong) PCCircleView *lockView;

/**
 *  infoView
 */
@property (nonatomic, strong) PCCircleInfoView *infoView;
/**
 *  登陆显示用户名信息
 */
@property (nonatomic,strong)PCLockLabel *userLable;

@end

@implementation GestureViewController
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    self.navigationController.navigationBar.translucent = YES;
    self.navBarHairlineImageView.hidden=NO;
}
-(BOOL)navigationShouldPopOnBackButton{
    if (self.delegate &&[self.delegate respondsToSelector:@selector(gestureLoginViewWithBack)]) {
        [self.delegate gestureLoginViewWithBack];
    }
    return YES;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navBarHairlineImageView.hidden=YES;

    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];

    if (self.type == GestureViewControllerTypeLogin) {
        self.navigationController.navigationBar.translucent = NO;
        
        self.navigationController.navigationBar.barTintColor = RGBCOLOR(36, 70, 126);
        [self.navigationItem setHidesBackButton:NO];
        [self.navigationController setNavigationBarHidden:NO animated:animated];
    }else{
        [self.navigationItem setHidesBackButton:YES];
        [self.navigationController setNavigationBarHidden:NO animated:animated];
    }
    if (self.type == GestureViewControllerTypeSetting) {
        //创建导航栏右边跳过按钮
        [self addRightNavigationItem];
    }
    // 进来先清空存的第一个密码
    [PCCircleViewConst saveGesture:nil Key:gestureOneSaveKey];
}
#pragma mark addRightNavigationItem
-(void)addRightNavigationItem{

    UIBarButtonItem *r =[[UIBarButtonItem alloc] initWithTitle:@"跳过" style:UIBarButtonItemStylePlain target:self action:@selector(_rightNavigationItemAction)];
    [r setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:12],NSFontAttributeName,[UIColor whiteColor],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]   initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace   target:nil action:nil];
    /**
     width为负数时，相当于btn向右移动width数值个像素，由于按钮本身和  边界间距为5pix，所以width设为-5时，间距正好调整为0；width为正数 时，正好相反，相当于往左移动width数值个像素
     */
    negativeSpacer.width = -8;
    self.navigationItem.rightBarButtonItems = @[negativeSpacer,r];
}
-(void)_rightNavigationItemAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    residueDegree = NumberOfGestureLockVerifications;
    
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    backgroundImageView.image = [UIImage imageNamed:@"login_background"];
    //[self.view addSubview:backgroundImageView];
    
    self.view.backgroundColor = RGBCOLOR(36, 70, 126);
    // 1.界面相同部分生成器
    [self setupSameUI];
    
    // 2.界面不同部分生成器
    [self setupDifferentUI];
}
#pragma mark - 界面不同部分生成器
- (void)setupDifferentUI
{
    switch (self.type) {
        case GestureViewControllerTypeSetting:
            [self setupSubViewsSettingVc];
            break;
        case GestureViewControllerTypeLogin:
            [self setupSubViewsLoginVc];
            break;
        case GestureViewControllerTypeModify:
            [self setupSubViewsLoginVc];
            break;
        default:
            break;
    }
}

#pragma mark - 界面相同部分生成器
- (void)setupSameUI
{
    // 创建“重新绘制”按钮
    _resetBtn = [self buttonWithTitle:@"重新绘制" target:self action:@selector(didClickBtn:) tag:buttonTagReset];
    [self.view addSubview:self.resetBtn];
    
    
    // 解锁界面
    PCCircleView *lockView = [[PCCircleView alloc] init];
    PCLockLabel *msgLabel = [[PCLockLabel alloc] init];
    msgLabel.frame = CGRectMake(0, 0, kScreenW, 15);
    switch (self.type) {
        case GestureViewControllerTypeLogin:
        {
//            BOOL whetherHide = [[NSUserDefaults standardUserDefaults] boolForKey:WHETHER_HIDE_GESTUREPATH];
            lockView = [[PCCircleView alloc] initWithType:CircleViewTypeLogin clip:YES arrow:NO solid:YES];
            
            msgLabel.center = CGPointMake(kScreenW/2, CGRectGetMinY(lockView.frame) - 10);
            
            PCLockLabel *msgLabel2 = [[PCLockLabel alloc] init];
            msgLabel2.frame = CGRectMake(0, 0, kScreenW, 15);
            msgLabel2.center = CGPointMake(kScreenW/2, CGRectGetMinY(msgLabel.frame) - 19);
            self.msgLabel2 = msgLabel2;
            [self.view addSubview:msgLabel2];
            break;
        }
         case GestureViewControllerTypeSetting:
        {
            lockView = [[PCCircleView alloc] initWithType:CircleViewTypeSetting clip:YES arrow:NO solid:YES];
            
            msgLabel.center = CGPointMake(kScreenW/2, CGRectGetMinY(lockView.frame) - 4);
            
            PCLockLabel *msgLabel2 = [[PCLockLabel alloc] init];
            msgLabel2.frame = CGRectMake(0, 0, kScreenW, 15);
            msgLabel2.center = CGPointMake(kScreenW/2, CGRectGetMinY(msgLabel.frame) - 19);
            self.msgLabel2 = msgLabel2;
            [self.view addSubview:msgLabel2];
            
            break;
        }
        case GestureViewControllerTypeModify: {
            lockView = [[PCCircleView alloc] initWithType:CircleViewTypeVerify clip:YES arrow:NO solid:YES];
            
            msgLabel.center = CGPointMake(kScreenW/2, CGRectGetMinY(lockView.frame) - 4);
            
            PCLockLabel *msgLabel2 = [[PCLockLabel alloc] init];
            msgLabel2.frame = CGRectMake(0, 0, kScreenW, 15);
            msgLabel2.center = CGPointMake(kScreenW/2, CGRectGetMinY(msgLabel.frame) - 19);
            self.msgLabel2 = msgLabel2;
            [self.view addSubview:msgLabel2];
            
            break;
        }
        default:
            break;
    }
    lockView.delegate = self;
    self.lockView = lockView;
    [self.view addSubview:lockView];
    
    self.msgLabel = msgLabel;
    [self.view addSubview:msgLabel];
}

#pragma mark - 设置手势密码界面
- (void)setupSubViewsSettingVc
{
    [self.lockView setType:CircleViewTypeSetting];
    
    self.title = @"设置手势密码";
    [self.msgLabel showNormalMsg:@""];
    [self.msgLabel2 showNormalMsg:gestureTextBeforeSet];
    
    PCCircleInfoView *infoView = [[PCCircleInfoView alloc] init];
    infoView.frame = CGRectMake(0, 0, CircleRadius * 2 * 0.8, CircleRadius *2 * 0.8);
    infoView.center = CGPointMake(kScreenW/2, CGRectGetMinY(self.msgLabel2.frame) - CGRectGetHeight(infoView.frame)/2 - 22);
    self.infoView = infoView;
    [self.view addSubview:infoView];
}

#pragma mark - 登陆手势密码界面
- (void)setupSubViewsLoginVc
{
    [self.lockView setType:CircleViewTypeLogin];
    self.title = @"请输入手势密码";
//    [self.msgLabel2 showNormalMsg:@"请输入手势密码"];

    
    _userLable = [[PCLockLabel alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 22)];
    _userLable.center = CGPointMake(kScreenW/2, kScreenW/4-10-30);
    _userLable.font = [UIFont systemFontOfSize:20];
    _userLable.textColor = [UIColor whiteColor];
    _userLable.text = @"用户名";
    _userLable.text = [self showUserLable];
    
    [self.view addSubview:_userLable];
    
    
    // 忘记手势密码
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self creatButton:leftBtn frame:CGRectMake(15, kScreenH - 50-64, kScreenW/2, 15) title:@"忘记手势密码" alignment:UIControlContentHorizontalAlignmentLeft tag:buttonTagManager];
    
    // 登录其他账户
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self creatButton:rightBtn frame:CGRectMake(kScreenW/2 - 15, kScreenH - 50-64, kScreenW/2, 15) title:@"用其他账号登录" alignment:UIControlContentHorizontalAlignmentRight tag:buttonTagForget];
}
//显示登陆标题信息
-(NSString *)showUserLable{
    NSString *userMegString = @"";
    NSString *ss = [JRCommon unarchieveWithFile:UserInfoSavePath key:@"keyLN"];
    NSString *keyLN= ss.length>0?[SecurityUtil gainStringDescryptAESHex:ss]:@"";
    if (keyLN.length<5) {
        return userMegString;
    }
    
    if (keyLN.length>=18) {
        NSMutableString *star = [NSMutableString string];
        for (int i=0; i<(keyLN.length-4-6); i++) {
            [star appendString:@"*"];
        }
        userMegString = [NSString stringWithFormat:@"%@%@%@",[keyLN substringToIndex:6],star,[keyLN substringFromIndex:14]];
    }else{
        NSMutableString *star = [NSMutableString string];
        if (keyLN.length>7) {
            for (int i=0; i<(keyLN.length-4-3); i++) {
                [star appendString:@"*"];
            }
            userMegString = [NSString stringWithFormat:@"%@%@%@",[keyLN substringToIndex:3],star,[keyLN substringFromIndex:keyLN.length-5]];
        }else{
            for (int i=0; i<(keyLN.length-4); i++) {
                [star appendString:@"*"];
            }
            userMegString = [NSString stringWithFormat:@"%@%@",star,[keyLN substringFromIndex:keyLN.length-5]];
        }
        
    }
    
    return userMegString;
}

#pragma mark - circleView - delegate
- (void)circleView:(PCCircleView *)view type:(CircleViewType)type connectCirclesLessThanNeedWithGesture:(NSString *)gesture
{
    NSString *gestureOne = [PCCircleViewConst getGestureWithKey:gestureOneSaveKey];

    // 看是否存在第一个密码
    if ([gestureOne length]) {
        [self.resetBtn setHidden:NO];
        [self.msgLabel showWarnMsgAndShake:gestureTextDrawAgainError];
    } else {
        NSLog(@"密码长度不合法%@", gesture);
        [self.msgLabel showWarnMsgAndShake:gestureTextConnectLess];
    }
}
#pragma mark - circleView - delegate -setting
- (void)circleView:(PCCircleView *)view type:(CircleViewType)type didCompleteSetFirstGesture:(NSString *)gesture
{
    NSLog(@"获得第一个手势密码%@", gesture);
    [self.msgLabel showNormalMsg:@""];
    [self.msgLabel2 showNormalMsg:gestureTextDrawAgain];
    [self.resetBtn setHidden:NO];

    // infoView展示对应选中的圆
    [self infoViewSelectedSubviewsSameAsCircleView:view];
}

- (void)circleView:(PCCircleView *)view type:(CircleViewType)type didCompleteSetSecondGesture:(NSString *)gesture result:(BOOL)equal
{
    NSLog(@"获得第二个手势密码%@",gesture);
    
    if (equal) {
        
        NSLog(@"两次手势匹配！可以进行本地化保存了");
        [self.msgLabel showNormalMsg:gestureTextSetSuccess];
        [PCCircleViewConst saveGesture:gesture Key:gestureFinalSaveKey];
        //是否有手势密码的标示设为YES
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:WHETHERGESTURELOCK];
        //是否隐藏手势路径
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:WHETHER_HIDE_GESTUREPATH];
        //下次不让设置手势密码
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:WHETHERCANLOGINGESTUREPASSWORD];

        
        MBProgressHUD *hud= [MBProgressHUD showHUDAddedTo:self.view  animated:YES];
        hud.detailsLabelText = @"设置成功";
        hud.mode = MBProgressHUDModeText;
        
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popToRootViewControllerAnimated:YES];
        });
        
    } else {
        NSLog(@"两次手势不匹配！");
        
        [self.msgLabel showWarnMsgAndShake:gestureTextDrawAgainError];
    }
}

#pragma mark - circleView - delegate - login or verify gesture
- (void)circleView:(PCCircleView *)view type:(CircleViewType)type didCompleteLoginGesture:(NSString *)gesture result:(BOOL)equal
{
    // 此时的type有两种情况 Login or verify
    if (type == CircleViewTypeLogin) {
        
        if (equal) {
            NSLog(@"登陆成功！");
            if (self.delegate && [self.delegate respondsToSelector:@selector(gesturePasswordLoginSuccess)])
            {
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:WHETHERGESTURELOCK];
                [self.navigationController popViewControllerAnimated:YES];
                [self.delegate gesturePasswordLoginSuccess];
            }
        } else {
            NSLog(@"密码错误！");
            NSString *alertMsg = [NSString stringWithFormat:@"密码错误，您还可以输入%d次!",--residueDegree];
            [self.msgLabel showWarnMsgAndShake:alertMsg];
            if (residueDegree == 0) {//验证达上限
                residueDegree = NumberOfGestureLockVerifications;
                //关闭手势密码的userDefault
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:WHETHERGESTURELOCK];
                [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:gestureFinalSaveKey];
                
                [[NSUserDefaults standardUserDefaults]setBool:NO forKey:WHETHERCANLOGINGESTUREPASSWORD];

                if (self.delegate && [self.delegate respondsToSelector:@selector(skipToLoginView)])
                {
                    [self.navigationController popViewControllerAnimated:YES];
                    [self.delegate skipToLoginView];
                }
            }
        }
    } else if (type == CircleViewTypeVerify) {
        
        if (equal) {
            NSLog(@"验证成功，跳转到设置手势界面");
            
        } else {
            NSLog(@"原手势密码输入错误！");
            
        }
    }
}
#pragma mark - button点击事件
- (void)didClickBtn:(UIButton *)sender
{
    NSLog(@"%ld", (long)sender.tag);
    switch (sender.tag) {
        case buttonTagReset:
        {
            NSLog(@"点击了重设按钮");
            // 1.隐藏按钮
            [self.resetBtn setHidden:YES];
            
            // 2.infoView取消选中
            [self infoViewDeselectedSubviews];
            
            // 3.msgLabel提示文字复位
            [self.msgLabel showNormalMsg:@""];
            
            // 4.msgLabel2提示文字复位
            [self.msgLabel2 showNormalMsg:gestureTextBeforeSet];
            
            // 5.清除之前存储的密码
            [PCCircleViewConst saveGesture:nil Key:gestureOneSaveKey];
        }
            break;
        case buttonTagManager:
        {
            NSLog(@"点击了忘记手势密码按钮");
            if (self.delegate &&[self.delegate respondsToSelector:@selector(forgetPasswordForGesuture)]) {
                [[NSUserDefaults standardUserDefaults]setBool:NO forKey:WHETHERCANLOGINGESTUREPASSWORD];
                [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:gestureFinalSaveKey];
                //关闭手势密码的userDefault
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:WHETHERGESTURELOCK];
                [self.navigationController popViewControllerAnimated:YES];
                [self.delegate forgetPasswordForGesuture];
            }
        }
            break;
        case buttonTagForget:
        {
            NSLog(@"点击了登录其他账户按钮");
            if (self.delegate &&[self.delegate respondsToSelector:@selector(loginOtherViewForGesture)]) {
                [[NSUserDefaults standardUserDefaults]setBool:NO forKey:WHETHERCANLOGINGESTUREPASSWORD];
                [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:gestureFinalSaveKey];
                //关闭手势密码的userDefault
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:WHETHERGESTURELOCK];
                [self.navigationController popViewControllerAnimated:YES];
                [self.delegate loginOtherViewForGesture];
            }
            
        }
            break;
        default:
            break;
    }
}
#pragma mark - infoView展示方法
#pragma mark - 让infoView对应按钮选中
- (void)infoViewSelectedSubviewsSameAsCircleView:(PCCircleView *)circleView
{
    for (PCCircle *circle in circleView.subviews) {
        
        if (circle.state == CircleStateSelected || circle.state == CircleStateLastOneSelected) {
            
            for (PCCircle *infoCircle in self.infoView.subviews) {
                if (infoCircle.tag == circle.tag) {
                    [infoCircle setState:CircleStateSelected];
                }
            }
        }
    }
}

#pragma mark - 让infoView对应按钮取消选中
- (void)infoViewDeselectedSubviews
{
    [self.infoView.subviews enumerateObjectsUsingBlock:^(PCCircle *obj, NSUInteger idx, BOOL *stop) {
        [obj setState:CircleStateNormal];
    }];
}
#pragma mark - 创建UIButton
- (void)creatButton:(UIButton *)btn frame:(CGRect)frame title:(NSString *)title alignment:(UIControlContentHorizontalAlignment)alignment tag:(NSInteger)tag
{
    btn.frame = frame;
    btn.tag = tag;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setContentHorizontalAlignment:alignment];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [btn addTarget:self action:@selector(didClickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
#pragma mark - 创建重新绘制UIButton
- (UIButton *)buttonWithTitle:(NSString *)title target:(id)target action:(SEL)action tag:(NSInteger)tag
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, 100, 15);
    button.center = CGPointMake(kScreenW/2, kScreenH - 48);
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button setBackgroundColor:[UIColor clearColor]];
    button.tag = tag;
    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [button setHidden:YES];
    return button;
}


@end
