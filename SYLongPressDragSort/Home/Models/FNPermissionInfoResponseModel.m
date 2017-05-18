//
//  FNPermissionInfoResponseModel.m
//  FNMerchant
//
//  Created by 张苏亚 on 16/6/23.
//  Copyright © 2016年 FeiNiu. All rights reserved.
//

#import "FNPermissionInfoResponseModel.h"

@implementation FNPermissionInfoResponseModel

+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"isHavePermission":@"body.isHavePermission"
             };
}


@end
