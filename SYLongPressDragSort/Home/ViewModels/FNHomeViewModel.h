//
//  FNHomeViewModel.h
//  FNMerchant
//
//  Created by 张苏亚 on 16/6/17.
//  Copyright © 2016年 FeiNiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FNHomeInfoModel.h"
@interface FNHomeViewModel : NSObject


@property (nonatomic, strong) NSMutableArray *biInfoArray;
@property (nonatomic, strong) NSMutableArray *modelInfoArray;
@property (nonatomic, strong) NSMutableArray *dsrInfoArray;
@property (nonatomic, strong) FNStoreInfoModel *store;

@property (nonatomic, strong,readonly) NSMutableArray *cellSizeArrray;
@property (nonatomic, strong,readonly) NSMutableArray *headerSizeArray;
@property (nonatomic, strong,readonly) NSMutableArray *footerSizeArray;

@property (nonatomic, strong)FNStoreManagementInfoModel *lastManagementInfoModel;

//布局信息

-(void)calculateLayoutInfo;
@end
