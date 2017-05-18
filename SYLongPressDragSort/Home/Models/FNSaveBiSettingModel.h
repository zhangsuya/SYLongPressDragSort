//
//  FNSaveBiSettingModel.h
//  FNMerchant
//
//  Created by 张苏亚 on 16/6/21.
//  Copyright © 2016年 FeiNiu. All rights reserved.
//
#import <MTLModel.h>
#import <MTLJSONAdapter.h>

@interface FNSaveBiSettingModel : MTLModel<MTLJSONSerializing>

@property (nonatomic,strong)NSArray *datalist;

@end
