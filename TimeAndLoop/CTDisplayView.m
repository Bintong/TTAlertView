//
//  CTDisplayView.m
//  TimeAndLoop
//
//  Created by BinTong on 2019/3/18.
//  Copyright © 2019 TongBin. All rights reserved.
//

#import "CTDisplayView.h"
#import "CoreTextImageData.h"
#import "CoreTextLinkData.h"
#import "CoreTextUtils.h"

@interface CTDisplayView()<UIGestureRecognizerDelegate>

@property (strong,nonatomic)UIImageView *tapImgeView;

@property (strong,nonatomic)UIView *coverView;

@property (strong,nonatomic)UIWebView *webView;
//@property (strong,nonatomic)


@end

@implementation CTDisplayView

- (void)dealloc {
    _coverView = nil;
    _webView = nil;
}

//初始化方法
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupEvents];
    }
    return self;
}

//添加点击手势
-(void)setupEvents{
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTapGestureDetected:)];
    tapRecognizer.delegate = self;
    [self addGestureRecognizer:tapRecognizer];
    self.userInteractionEnabled = YES;
}

//增加UITapGestureRecognizer的回调函数
-(void)userTapGestureDetected:(UITapGestureRecognizer *)recognizer{
    
    CGPoint point = [recognizer locationInView:self];
    for (CoreTextImageData *imagData in self.data.imageArray) {
        
        //翻转坐标系，因为ImageData中的坐标是CoreText的坐标系
        CGRect imageRect = imagData.imagePostion;
        CGPoint imagePosition = imageRect.origin;
        imagePosition.y = self.bounds.size.height - imageRect.origin.y - imageRect.size.height;
        CGRect rect = CGRectMake(imagePosition.x, imagePosition.y, imageRect.size.width, imageRect.size.height);
        
        //检测点击位置Point是否在rect之内
        if (CGRectContainsPoint(rect, point)) {
            
            //在这里处理点击后的逻辑
            [self showTapImage:[UIImage imageNamed:imagData.name]];
            break;
        }
    }
    
    //web
    //点击链接
    CoreTextLinkData *linkData = [CoreTextUtils touchLinkInView:self atPoint:point data:self.data];
    if (linkData) {
        [self showTapLink:linkData.url];
        return;
    }
}

//显示图片
-(void)showTapImage:(UIImage *)tapImage{
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    //图片
    _tapImgeView = [[UIImageView alloc] initWithImage:tapImage];
    _tapImgeView.frame = CGRectMake(0, 0, 300, 200);
    _tapImgeView.center = keyWindow.center;
    
    //蒙版
    _coverView = [[UIView alloc] initWithFrame:keyWindow.bounds];
    [_coverView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancel)]];
    _coverView.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.6];
    _coverView.userInteractionEnabled = YES;
    
    [keyWindow addSubview:_coverView];
    [keyWindow addSubview:_tapImgeView];
}

-(void)cancel{
    [_tapImgeView removeFromSuperview];
    [_coverView removeFromSuperview];
}


//显示链接网页
-(void)showTapLink:(NSString *)urlStr{
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    //网页
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 300, 400)];
    _webView.center = keyWindow.center;
    [_webView setScalesPageToFit:YES];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [_webView loadRequest:request];
    
    //蒙版
    _coverView = [[UIView alloc] initWithFrame:keyWindow.bounds];
    [_coverView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)]];
    _coverView.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.6];
    _coverView.userInteractionEnabled = YES;
    
    [keyWindow addSubview:_coverView];
    [keyWindow addSubview:_webView];
}
-(void)hide{
    [_webView removeFromSuperview];
    [_coverView removeFromSuperview];
}

//重写drawRect方法
- (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    
    //1.获取当前绘图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
//    2.旋转坐坐标系(默认和UIKit坐标是相反的)
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    //3.绘制内容
//    if (self.data) {
//        CTFrameDraw(self.data.ctFrame, context);
//    }
    if (self.data) {
        
        CTFrameDraw(self.data.ctFrame, context); //文字绘画
        for (CoreTextImageData *imageData in self.data.imageArray) {
            
            UIImage *image = [UIImage imageNamed:imageData.name];
            CGContextDrawImage(context, imageData.imagePostion, image.CGImage);//图片绘画
        }
    }
    
    [super drawRect:rect];
}

@end
