//
//  FNSaveStoreManagementSettingModel.h
//  FNMerchant
//
//  Created by 张苏亚 on 16/6/21.
//  Copyright © 2016年 suya. All rights reserved.
//

#import <MTLModel.h>
#import <MTLJSONAdapter.h>

@interface FNSaveStoreManagementSettingModel : MTLModel<MTLJSONSerializing>
@property (nonatomic,strong)NSArray *datalist;
@end
