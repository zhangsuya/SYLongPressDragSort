//
//  SYLTabBar.h
//  MarkDemo
//
//  Created by 张苏亚 on 16/5/26.
//  Copyright © 2016年 张苏亚. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SYLTabBarButton.h"

@class SYLTabBarButton;
@class SYLTabBar;

@protocol SYLTabBarDelegate <NSObject>

@optional

- (void)tabBar:(SYLTabBar *)tabBar didSelectButtonIndexFromTag:(NSInteger)fromTag toTag:(NSInteger)toTag;


@end

@interface SYLTabBar : UIView

@property (nonatomic, assign) id<SYLTabBarDelegate> delegate;

/**
 *  提供创建分栏上按钮的方法
 *
 *  @param name    按钮正常状态下的图片名
 *  @param selName 按钮选中状态下的图片名
 */
- (void)addButtonWithImageName:(NSString *)name selImageName:(NSString *)selName;

- (void)addButtonWithImageName:(NSString *)name selImageName:(NSString *)selName titleName:(NSString *)titleName;

- (void)changeSelectdeBtn:(SYLTabBarButton *)btn;

@end
