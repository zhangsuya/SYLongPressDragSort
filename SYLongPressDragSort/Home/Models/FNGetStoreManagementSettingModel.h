//
//  FNGetStoreManagementSettingModel.h
//  FNMerchant
//
//  Created by 张苏亚 on 16/6/20.
//  Copyright © 2016年 FeiNiu. All rights reserved.
//
#import <MTLModel.h>
#import <MTLJSONAdapter.h>

@interface FNGetStoreManagementSettingModel : MTLModel<MTLJSONSerializing>

@property (nonatomic,strong)NSArray *dataList;

@end

@interface FNStoreManagementSettingModel : MTLModel<MTLJSONSerializing>

@property (nonatomic,copy) NSString *code;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,strong) NSNumber *isVisible;
@property (nonatomic,assign) NSInteger requestCount;

@end
