//
//  UIColor+Hex.h
//  MarkDemo
//
//  Created by 张苏亚 on 16/5/27.
//  Copyright © 2016年 张苏亚. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)

+ (UIColor *)colorWithHexString:(NSString *)color;

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;


@end
