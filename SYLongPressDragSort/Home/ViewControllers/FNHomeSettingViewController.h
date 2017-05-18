//
//  FNHomeSettingViewController.h
//  FNMerchant
//
//  Created by 张苏亚 on 16/6/20.
//  Copyright © 2016年 FeiNiu. All rights reserved.
//

//#import "FNBaseViewController.h"

typedef NS_ENUM(NSInteger,FNHomeSettingViewControllerStyle)
{
    FNHomeSettingViewControllerStyleBi = 0,
    FNHomeSettingViewControllerStyleManagement
};

extern NSString *const FNManagementSettingVisibleChange;
extern NSString *const FNBiSettingVisibleChange;

@interface FNHomeSettingViewController : UIViewController

-(instancetype)initWithViewControllerStyle:(FNHomeSettingViewControllerStyle )addItemViewControllerStyle;

@end
