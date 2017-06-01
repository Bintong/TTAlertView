

#import <UIKit/UIKit.h>

typedef void(^ScrollPage)(int);

@interface SelecterContentScrollView : UIScrollView

-(void)updateVCViewFromIndex:(NSInteger )index;

-(instancetype)initWithSeleterConditionTitleArr:(NSArray *)vcArr andBtnBlock:(ScrollPage)page;



@end
