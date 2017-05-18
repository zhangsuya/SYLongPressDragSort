//
//  FNGetBiSettingModel.m
//  FNMerchant
//
//  Created by 张苏亚 on 16/6/20.
//  Copyright © 2016年 FeiNiu. All rights reserved.
//

#import "FNGetBiSettingModel.h"

@implementation FNGetBiSettingModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"dataList" :@"body.dataList",
             };
    
}

+ (NSValueTransformer *)dataListJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:FNBiSettingModel.class];
}

@end

@implementation FNBiSettingModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"code" :@"code",
             @"name" :@"name",
             @"isVisible" :@"isVisible"
             };
    
}

@end