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

@end

@implementation TexureCellNode

-(instancetype)initWithModel:(TeureModel *)video {
    if (self = [super init]) {
        _titleTextNode = [[ASTextNode alloc] init];
        _titleTextNode.attributedText = [[NSAttributedString alloc] initWithString:video.title attributes:nil];
        [self addSubnode:_titleTextNode];
    }
    return self;
}

-(ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize{
    

    self.titleTextNode.style.layoutPosition = CGPointMake(16, 8);
    self.titleTextNode.style.preferredLayoutSize = ASLayoutSizeMake(ASDimensionMake(100), ASDimensionMake(100));
    
    ASAbsoluteLayoutSpec *absoluteLayout = [ASAbsoluteLayoutSpec absoluteLayoutSpecWithChildren:@[self.titleTextNode]];
    return absoluteLayout;
}

@end
