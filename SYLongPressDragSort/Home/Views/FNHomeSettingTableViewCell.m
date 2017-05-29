//
//  FNSettingTableViewCell.m
//  FNMerchant
//
//  Created by 张苏亚 on 16/8/31.
//  Copyright © 2016年 suya. All rights reserved.
//

#import "FNHomeSettingTableViewCell.h"
#import "FNGetStoreManagementSettingModel.h"
#import "FNHomeSettingViewController.h"
#import "FNGetBiSettingModel.h"
@interface FNHomeSettingTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *settingTextLabel;
@property (weak, nonatomic) IBOutlet FNSwitch *settingSwitch;

@end

@implementation FNHomeSettingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setVCStyle:(FNHomeSettingViewControllerStyle )style model:(__kindof MTLModel *)model
{
//    _settingSwitch.onTintColor = [UIColor fn_color:FNColor_green];
    _settingSwitch.exclusiveTouch = YES;

    if (style ==FNHomeSettingViewControllerStyleBi) {
        FNBiSettingModel *biSettingInfoModel = model;
        _settingTextLabel.text = [NSString stringWithFormat:@"%@",biSettingInfoModel.name];
        if ([biSettingInfoModel.isVisible integerValue] ==0) {
            _settingSwitch.on = NO;
        }else if ([biSettingInfoModel.isVisible integerValue] ==1)
        {
            _settingSwitch.on = YES;
        }
        
    }else if (style ==FNHomeSettingViewControllerStyleManagement)
    {
        FNStoreManagementSettingModel *modelSettingInfoModel = model;
        _settingTextLabel.text = [NSString stringWithFormat:@"%@",modelSettingInfoModel.name];
        if ([modelSettingInfoModel.isVisible integerValue] ==0) {
            
            _settingSwitch.on = NO;
            
        }else if ([modelSettingInfoModel.isVisible integerValue] ==1)
        {
            _settingSwitch.on = YES;
        }
    }
//    [_settingSwitch addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
}

- (IBAction)switchChanged:(FNSwitch *)sender {
    
    if ([_delegate respondsToSelector:@selector(settingSwitchChanged:)]) {
        
        [_delegate settingSwitchChanged:sender];
    }
}


@end
