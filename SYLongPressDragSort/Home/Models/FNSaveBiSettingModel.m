//
//  FNSaveBiSettingModel.m
//  FNMerchant
//
//  Created by 张苏亚 on 16/6/21.
//  Copyright © 2016年 suya. All rights reserved.
//

#import "FNSaveBiSettingModel.h"
#import "FNGetBiSettingModel.h"
#import "NSValueTransformer+MTLPredefinedTransformerAdditions.h"

@implementation FNSaveBiSettingModel

+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"datalist":@"body.datalist"};
}

+ (NSValueTransformer *)datalistJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:
            [FNBiSettingModel class]];
}

@end
