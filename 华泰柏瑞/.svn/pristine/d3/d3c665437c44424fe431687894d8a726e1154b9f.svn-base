
#import <UIKit/UIKit.h>

/**
 *  单个圆的各种状态
 */
typedef enum{
    CircleStateNormal = 1,
    CircleStateSelected,
    CircleStateError,
    CircleStateLastOneSelected,
    CircleStateLastOneError
}CircleState;

/**
 *  单个圆的用途类型
 */
typedef enum
{
    CircleTypeInfo = 1,
    CircleTypeGesture
}CircleType;

@interface PCCircle : UIView

/**
 *  所处的状态
 */
@property (nonatomic, assign) CircleState state;

/**
 *  类型
 */
@property (nonatomic, assign) CircleType type;

/**
 *  是否有箭头 default is YES
 */
@property (nonatomic, assign) BOOL arrow;

/**
 *  是否有实心圆
 */
@property (nonatomic, assign) BOOL solid;

/** 角度 */
@property (nonatomic,assign) CGFloat angle;

@end
