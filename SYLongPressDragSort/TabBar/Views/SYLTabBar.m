//
//  SYLTabBar.m
//  SYLongPressDragSort
//
//  Created by 张苏亚 on 16/5/26.
//  Copyright © 2016年 张苏亚. All rights reserved.
//

#import "SYLTabBar.h"
#import "SYLMacros.h"
@interface SYLTabBar()

/**
 *  保存当前用户选中的按钮
 */
@property (nonatomic, assign) SYLTabBarButton *selectedBtn;

@end

#define BTN_START_TAG 100

@implementation SYLTabBar

#pragma mark - Lifecycle

-(instancetype)init
{
    if (self = [super init]) {
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.userInteractionEnabled = YES;
    }
    
    return self;
}



/**
 *  当控件的大小改变以后，会自动调用。
 *  在这个方法中，重新布局子控件
 */
- (void)layoutSubviews
{
    //这行代码一定不能省
    [super layoutSubviews];
    
    NSUInteger count = [self.subviews count];
    for (int i = 0; i < count; i++) {
        //取到按钮
        SYLTabBarButton *btn = self.subviews[i];
        btn.tag = i + BTN_START_TAG;
        
        //设置第一个按钮的选中状态
        if (i == 0) {
            btn.selected = YES;
            //保存当前选中的按钮
            self.selectedBtn = btn;
        }
        
        //修改按钮的frame
        CGFloat btnW = self.bounds.size.width / count;
        CGFloat btnH = self.bounds.size.height;
        CGFloat btnX = i * btnW;
        CGFloat btnY = 0;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
}



- (void)btnClick:(SYLTabBarButton *)btn
{
    //通知代理，当前tabBar 从哪个按钮跳到了哪个按钮
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectButtonIndexFromTag:toTag:)]) {
        [self.delegate tabBar:self didSelectButtonIndexFromTag:(self.selectedBtn.tag - BTN_START_TAG) toTag:(btn.tag - BTN_START_TAG)];
    }
    
    //原来选中按钮取消选中
    //    self.selectedBtn.selected = NO;
    
    //设置被点击的按钮的选中状态
    //    btn.selected = YES;
    
    //保存当前选中的按钮
    //    self.selectedBtn = btn;
}
- (void)addButtonWithImageName:(NSString *)name selImageName:(NSString *)selName titleName:(NSString *)titleName
{
    SYLTabBarButton *btn = [SYLTabBarButton buttonWithType:UIButtonTypeCustom];
    
    [btn setTitleColor:BlackStringColor forState:UIControlStateNormal];
    [btn setTitleColor:GreenBackgroundColor forState:UIControlStateSelected];
    
    btn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    [btn setTitle:titleName forState:UIControlStateNormal];
    [btn setTitle:titleName forState:UIControlStateSelected];

    [btn setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:selName] forState:UIControlStateSelected];
    btn.imageView.contentMode  = UIViewContentModeScaleToFill;
    
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:btn];
}

- (void)addButtonWithImageName:(NSString *)name selImageName:(NSString *)selName
{
    SYLTabBarButton *btn = [SYLTabBarButton buttonWithType:UIButtonTypeCustom];
    
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    
    btn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    
    
    [btn setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:selName] forState:UIControlStateSelected];
    btn.imageView.contentMode  = UIViewContentModeScaleToFill;
    
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:btn];
}

- (void)changeSelectdeBtn:(SYLTabBarButton *)btn
{
    self.selectedBtn = btn;
}



@end
