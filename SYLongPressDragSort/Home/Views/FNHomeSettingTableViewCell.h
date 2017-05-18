//
//  FNSettingTableViewCell.h
//  FNMerchant
//
//  Created by 张苏亚 on 16/8/31.
//  Copyright © 2016年 FeiNiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNSwitch.h"

@protocol FNHomeSettingTableViewCellDelegate <NSObject>

-(void)settingSwitchChanged:(FNSwitch *)settingSwitch;

@end

@interface FNHomeSettingTableViewCell : UITableViewCell

@property (nonatomic, assign) id<FNHomeSettingTableViewCellDelegate> delegate;

@end
