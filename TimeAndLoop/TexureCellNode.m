//
//  TexureCellNode.m
//  TimeAndLoop
//
//  Created by BinTong on 2019/2/17.
//  Copyright © 2019 TongBin. All rights reserved.
//

#import "TexureCellNode.h"
@interface TexureCellNode()

@property (strong, nonatomic) ASTextNode *titleTextNode;

@property (strong, nonatomic) ASImageNode *imageNode;

@end

@implementation TexureCellNode

-(instancetype)initWithModel:(TeureModel *)video {
    if (self = [super init]) {
        _titleTextNode = [[ASTextNode alloc] init];
        _titleTextNode.attributedText = [[NSAttributedString alloc] initWithString:video.title attributes:nil];
    
        _titleTextNode.backgroundColor = [UIColor redColor];
        _imageNode = [[ASImageNode alloc] init];
        _imageNode.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",video.imgUrlName]];
        [self addSubnode:_titleTextNode];
        [self addSubnode:_imageNode];
    }
    return self;
}

-(ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize{
    
    
    self.titleTextNode.style.spacingBefore = 12.0f;

    
    ASRatioLayoutSpec *rationLayout = [ASRatioLayoutSpec ratioLayoutSpecWithRatio:0.5 child:self.imageNode];
    
    ASStackLayoutSpec *contentLayout = [ASStackLayoutSpec verticalStackLayoutSpec];
    contentLayout.justifyContent = ASStackLayoutJustifyContentStart;
    contentLayout.alignItems = ASStackLayoutAlignItemsStretch;
    contentLayout.children = @[
                               rationLayout,
                               self.titleTextNode
                               ];
    ASInsetLayoutSpec *insetLayout = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(16, 16, 16, 16) child:contentLayout];
    return insetLayout;
}

@end
