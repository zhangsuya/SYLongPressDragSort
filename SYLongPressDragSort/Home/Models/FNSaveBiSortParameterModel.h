//
//  FNSaveBiSortParameterModel.h
//  FNMerchant
//
//  Created by 张苏亚 on 16/6/23.
//  Copyright © 2016年 suya. All rights reserved.
//
#import <MTLModel.h>
#import <MTLJSONAdapter.h>

@interface FNSaveBiSortParameterModel : MTLModel<MTLJSONSerializing>

@property (nonatomic,copy) NSString *sort;

@end
