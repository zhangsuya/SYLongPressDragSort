//
//  FNHomeInfoModel.h
//  FNMerchant
//
//  Created by 张苏亚 on 16/6/17.
//  Copyright © 2016年 suya. All rights reserved.
//

#import <MTLModel.h>
#import <MTLJSONAdapter.h>
@interface FNStoreInfoModel : MTLModel<MTLJSONSerializing>

@property (nonatomic,copy) NSString *iconImageUrl;
@property (nonatomic,copy) NSString *shopName;

@end


//首页数据报表dataArray层
@interface FNStoreBiInfoArrayModel : MTLModel<MTLJSONSerializing>

@property (nonatomic,strong) NSArray *dataList;

@end





//首页数据报表
@interface FNStoreBiInfoModel : MTLModel<MTLJSONSerializing>

@property (nonatomic,copy) NSString *code;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *data;

@end

///dataArray层
@interface FNStoreDsrInfoArrayModel : MTLModel<MTLJSONSerializing>

@property (nonatomic,strong) NSArray *dataList;


@end



//店铺评分数据
@interface FNStoreDsrInfoModel : MTLModel<MTLJSONSerializing>

@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *data;

@property (nonatomic,copy) NSString *than;
@property (nonatomic,copy) NSString *rate;

@property (nonatomic,copy) NSAttributedString *rateData;

@end

//dataArray层

@interface FNStoreManagementInfoArrayModel : MTLModel<MTLJSONSerializing>

@property (nonatomic,strong) NSArray *dataList;

@end




// 首页厂商管理
@interface FNStoreManagementInfoModel : MTLModel<MTLJSONSerializing>

@property (nonatomic,copy) NSString *code;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *url;
@property (nonatomic,copy) NSString *iconImageUrl;

@end






@interface FNHomeInfoModel : MTLModel<MTLJSONSerializing>
@property(nonatomic,strong)FNStoreInfoModel *store;
@property(nonatomic,strong)FNStoreBiInfoArrayModel *bi;
@property(nonatomic,strong)FNStoreDsrInfoArrayModel *dsr;
@property(nonatomic,strong)FNStoreManagementInfoArrayModel *manage;

@end
