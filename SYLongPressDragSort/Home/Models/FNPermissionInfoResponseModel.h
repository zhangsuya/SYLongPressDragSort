//
//  FNPermissionInfoResponseModel.h
//  FNMerchant
//
//  Created by 张苏亚 on 16/6/23.
//  Copyright © 2016年 FeiNiu. All rights reserved.
//
#import <MTLModel.h>
#import <MTLJSONAdapter.h>

@interface FNPermissionInfoResponseModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSNumber *isHavePermission;

@end
