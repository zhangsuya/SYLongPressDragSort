//
//  FNGetPermissionInfoModel.m
//  FNMerchant
//
//  Created by 张苏亚 on 16/6/23.
//  Copyright © 2016年 suya. All rights reserved.
//

#import "FNGetPermissionInfoModel.h"

@implementation FNGetPermissionInfoModel

+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"code":@"body.code",
             @"name":@"body.name"
             };
}

@end
