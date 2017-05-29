//
//  FNGetStoreManagementSettingModel.m
//  FNMerchant
//
//  Created by 张苏亚 on 16/6/20.
//  Copyright © 2016年 suya. All rights reserved.
//

#import "FNGetStoreManagementSettingModel.h"
#import "NSValueTransformer+MTLPredefinedTransformerAdditions.h"

@implementation FNGetStoreManagementSettingModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"dataList" :@"body.dataList",
             };
    
}

+ (NSValueTransformer *)dataListJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:FNStoreManagementSettingModel.class];
}


@end

@implementation FNStoreManagementSettingModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"code" :@"code",
             @"name" :@"name",
             @"isVisible" :@"isVisible"
             };
    
}



@end
