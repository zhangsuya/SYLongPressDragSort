//
//  FNMCollectionView.m
//  FNMerchant
//
//  Created by 张苏亚 on 16/7/12.
//  Copyright © 2016年 FeiNiu. All rights reserved.
//

#import "FNMCollectionView.h"

@implementation FNMCollectionView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
//    self.delaysContentTouches = NO;
//    self.canCancelContentTouches = YES;
    
    // Remove touch delay (since iOS 8)
//    UIView *wrapView = self.subviews.firstObject;
//    // UICollectionViewWrapperView
//    if (wrapView && [NSStringFromClass(wrapView.class) hasSuffix:@"WrapperView"]) {
//        for (UIGestureRecognizer *gesture in wrapView.gestureRecognizers) {
//            // UIScrollViewDelayedTouchesBeganGestureRecognizer
//            if ([NSStringFromClass(gesture.class) containsString:@"DelayedTouchesBegan"] ) {
////                gesture.enabled = NO;
//                break;
//            }
//        }
//    }
    
    return self;
}

//- (BOOL)touchesShouldCancelInContentView:(UIView *)view {
//    if ( [view isKindOfClass:[UIControl class]]) {
//        return YES;
//    }
//    return [super touchesShouldCancelInContentView:view];
//}

//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
////    [super touchesBegan:touches withEvent:event];
//    NSLog(@"%@",@"touchCollection");
//}

@end
