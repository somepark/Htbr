
#import "GestureVerifyViewController.h"
#import "PCCircleViewConst.h"
#import "PCCircleView.h"
#import "PCLockLabel.h"
#import "GestureViewController.h"

@interface GestureVerifyViewController ()<CircleViewDelegate>

/**
 *  文字提示Label
 */
@property (nonatomic, strong) PCLockLabel *msgLabel;
@property (nonatomic, strong) PCLockLabel *msgLabel2;

@end

@implementation GestureVerifyViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
//        [self.view setBackgroundColor:CircleViewBackgroundColor];
        
        UIGraphicsBeginImageContext(self.view.bounds.size);
        [[UIImage imageNamed:@"login_background"] drawInRect:self.view.bounds];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"验证手势解锁";
    
    PCCircleView *lockView = [[PCCircleView alloc] initWithType:CircleViewTypeVerify clip:YES arrow:NO solid:YES];
    lockView.delegate = self;
    [lockView setType:CircleViewTypeVerify];
    [self.view addSubview:lockView];
    
    PCLockLabel *msgLabel = [[PCLockLabel alloc] init];
    msgLabel.frame = CGRectMake(0, 0, kScreenW, 14);
    msgLabel.center = CGPointMake(kScreenW/2, CGRectGetMinY(lockView.frame) - 26);
    [msgLabel showNormalMsg:@""];
    self.msgLabel = msgLabel;
    [self.view addSubview:msgLabel];
    
    PCLockLabel *msgLabel2 = [[PCLockLabel alloc] init];
    msgLabel2.frame = CGRectMake(0, 0, kScreenW, 14);
    msgLabel2.center = CGPointMake(kScreenW/2, CGRectGetMinY(msgLabel.frame) - 28);
    [msgLabel2 showNormalMsg:gestureTextOldGesture];
    self.msgLabel2 = msgLabel;
    [self.view addSubview:msgLabel2];

}

#pragma mark - login or verify gesture
- (void)circleView:(PCCircleView *)view type:(CircleViewType)type didCompleteLoginGesture:(NSString *)gesture result:(BOOL)equal
{
    if (type == CircleViewTypeVerify) {
        
        if (equal) {
            NSLog(@"验证成功");
            
            if (self.isToSetNewGesture) {
                [self.msgLabel2 showNormalMsg:@""];
                GestureViewController *gestureVc = [[GestureViewController alloc] init];
                [gestureVc setType:GestureViewControllerTypeSetting];
                [self.navigationController pushViewController:gestureVc animated:YES];
            } else {
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
            
        } else {
            NSLog(@"原密码错误！");
            [self.msgLabel2 showWarnMsgAndShake:gestureTextGestureVerifyError];
        }
    }
}

@end
