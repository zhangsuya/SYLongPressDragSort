//
//  SYLMacros.h
//  SYLongPressDragSort
//
//  Created by 张苏亚 on 17/5/18.
//  Copyright © 2017年 张苏亚. All rights reserved.
//

#ifndef SYLMacros_h
#define SYLMacros_h

//当前设备的宽高
#define kDeviceHeight [UIScreen mainScreen].bounds.size.height
#define kDeviceWidth  [UIScreen mainScreen].bounds.size.width

#define HEIGHT_TWO_IMAG_WITH          (kDeviceWidth - 80 - 14 -16)/3

#define kTabBarHeight         (49)
#define kDeviceHeight_No_NavigationHeight   (kDeviceHeight - 64)

#define selfWidth    self.view.frame.size.width
#define selfHeight    self.view.frame.size.height

//判断设备
#define DEV_SCREEN(width, height)	(([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(width, height), [[UIScreen mainScreen] currentMode].size) : NO))
#define iPad			([[UIDevice currentDevice].model isEqualToString:@"iPad"])
#define iPhone			([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
#define iPhone_Normal	(DEV_SCREEN(320, 480))
#define iPhone_Retina	(DEV_SCREEN(640, 960))
#define iPhone5			(DEV_SCREEN(640, 1136))
#define iPhone6			(DEV_SCREEN(750, 1334))
#define iPhone6p		(DEV_SCREEN(1242, 2208))
#define iPad_Normal		(DEV_SCREEN(768, 1024))
#define iPad_Retina		(DEV_SCREEN(768*2, 1024*2))
//黑色字体
#define BlackStringColor  [UIColor colorWithHexString:@"#333333"]
//灰色字体
#define GrayStringColor [UIColor colorWithHexString:@"#666666"]
//浅灰色字体
#define LightGrayStringColor [UIColor colorWithHexString:@"#999999"]
//白色字体
#define WhiteStringColor [UIColor colorWithHexString:@"#ffffff"]
//绿色背景色
#define GreenBackgroundColor [UIColor colorWithHexString:@"#1E977F"]
//灰绿背景色
#define GrayGreenBackgroundColor [UIColor colorWithHexString:@"#50AC99"]


//灰色背景
#define GrayBackgroundColor [UIColor colorWithHexString:@"#EEEEEE"]
//灰色线
#define GrayLineColor [UIColor colorWithHexString:@"#D5D5D5"]

#endif /* SYLMacros_h */
