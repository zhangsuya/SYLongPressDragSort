//
//  FNSaveStoreManagementSettingModel.m
//  FNMerchant
//
//  Created by 张苏亚 on 16/6/21.
//  Copyright © 2016年 suya. All rights reserved.
//

#import "FNSaveStoreManagementSettingModel.h"
#import "FNGetStoreManagementSettingModel.h"

@implementation FNSaveStoreManagementSettingModel

+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"datalist":@"body.datalist"};
}

+ (NSValueTransformer *)datalistJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:
            [FNStoreManagementSettingModel class]];
}

@end
