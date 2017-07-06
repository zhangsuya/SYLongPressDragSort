//
//  SYLTabBarButton.m
//  SYLongPressDragSort
//
//  Created by 张苏亚 on 16/5/26.
//  Copyright © 2016年 张苏亚. All rights reserved.
//

#import "SYLTabBarButton.h"
#import "UIView+Additions.h"
#import "SYLMacros.h"
@implementation SYLTabBarButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


#pragma mark - Lifecycle


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
//        [self.titleLabel setTextColor:GrayStringColor];
    }
    return self;
}

#pragma mark - overwriter super method

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat h = 24;
    CGFloat w = 25;
    CGFloat x = (self.fwidth - w) * 0.5;
    CGFloat y = 5;
    return CGRectMake(x, y, w, h);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, 24 +8, self.fwidth, 12);
}

@end
