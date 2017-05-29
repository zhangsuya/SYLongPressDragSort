//
//  FNGetPermissionInfoModel.h
//  FNMerchant
//
//  Created by 张苏亚 on 16/6/23.
//  Copyright © 2016年 suya. All rights reserved.
//

#import <MTLModel.h>
#import <MTLJSONAdapter.h>
@interface FNGetPermissionInfoModel : MTLModel<MTLJSONSerializing>

@property (nonatomic,copy)NSString *code;
@property (nonatomic,copy)NSString *name;

@end
