
#import <UIKit/UIKit.h>
#import "JRBaseViewController.h"
typedef enum{
    GestureViewControllerTypeSetting = 1,
    GestureViewControllerTypeLogin,
    GestureViewControllerTypeModify,
}GestureViewControllerType;

typedef enum{
    buttonTagReset = 1,
    buttonTagManager,
    buttonTagForget,
    buttonTagSkip
    
}buttonTag;

@class GestureViewController;
@protocol GestureViewControllerDelegate <NSObject>

@optional
///手势密码登录成功
- (void)gesturePasswordLoginSuccess;
///推出
- (void)skipToLoginView;

//点击忘记手势密码
-(void)forgetPasswordForGesuture;
//点击登录其他用户
-(void)loginOtherViewForGesture;

//验证手势密码验证界面，点击返回按钮
-(void)gestureLoginViewWithBack;
@end

@interface GestureViewController :JRBaseViewController

/**
 *  控制器来源类型
 */
@property (nonatomic, assign) GestureViewControllerType type;
@property (weak) id<GestureViewControllerDelegate>delegate;

@end
