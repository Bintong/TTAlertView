//
//  JFInvestTitleView.m
//  JiuFuWallet
//
//  Created by BinTong on 2017/11/22.
//  Copyright © 2017年 jayden. All rights reserved.
//

#import "JFInvestTitleView.h"

@implementation JFInvestTitleView

- (void)bindViewModel:(id)viewModel {
    
}


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}
- (void)loadView {
    if (self.projects && self.projects.count > 0) {
        if (self.projects.count <=2) {
            for (NSString *title in self.projects) {
                
                NSInteger i = [self.projects indexOfObject:title];
                UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.frame = CGRectMake(i * SCREEN_WIDTH/2 , 0, SCREEN_WIDTH/2, 60);
                button.backgroundColor = [UIColor redColor];
                [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:button];
              
                self.height = 200;
            }
        }else{
            for (NSString *title in self.projects) {
                NSInteger i = [self.projects indexOfObject:title];
                UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
                    button.frame = CGRectMake(SCREEN_WIDTH/4 * i , 0, SCREEN_WIDTH/4, 60);
                if (i> 3) {
                    NSInteger lineNum = floor(i/4);
                    button.frame = CGRectMake((i - 4*lineNum) *  SCREEN_WIDTH/4 , 60  , SCREEN_WIDTH/4, 60);//折行
                }
                button.backgroundColor = [UIColor whiteColor];
                UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jfbIcon.png"]];
                imageView.top = 20;
                imageView.centerX = button.bounds.size.width/2;
                [button addSubview:imageView];
                
                UILabel *lab = [self labelWithFontSize:12 FontColor:JF_COLOR_B frame:CGRectMake(0, 60 - 12, SCREEN_WIDTH/4, 12) Text:title];
                [button addSubview:lab];
                
                
                [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:button];
              
                self.height = 120 * floor(i/4) + 46;
            }
        }
    }
}



- (UILabel *)labelWithFontSize:(CGFloat)fontSize FontColor:(UIColor *)fontColor  frame:(CGRect)frame Text:(NSString *)text{
    UILabel *lbTitle = [[UILabel alloc] initWithFrame:frame];
    lbTitle.backgroundColor = [UIColor clearColor];
    lbTitle.font = [UIFont systemFontOfSize:fontSize];
    lbTitle.textColor = fontColor;
    lbTitle.textAlignment = NSTextAlignmentCenter;
    lbTitle.text = text;
    return lbTitle;
}

- (void)click:(id)sender {

}



@end
