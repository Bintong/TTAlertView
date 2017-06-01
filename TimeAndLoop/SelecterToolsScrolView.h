
#import <UIKit/UIKit.h>
typedef void(^BtnClick)(UIButton *);


typedef enum : NSUInteger {
    TriggerTypeOfBtnClick,
    TriggerTypeOfScrViewScroll,
} TriggerType;

@interface SelecterToolsScrolView : UIScrollView


-(void)updateSelecterToolsIndex:(NSInteger )index;


-(instancetype)initWithSeleterConditionTitleArr:(NSArray *)titleArr andBtnBlock:(BtnClick)btnClick;

@end
