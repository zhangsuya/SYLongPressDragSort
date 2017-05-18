//
//  FNHomeInfoModel.m
//  FNMerchant
//
//  Created by 张苏亚 on 16/6/17.
//  Copyright © 2016年 FeiNiu. All rights reserved.
//

#import "FNHomeInfoModel.h"

@implementation FNStoreInfoModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"iconImageUrl" : @"iconImageUrl",
             @"shopName" : @"shopName"
             };
}

@end
//dataArray层

@implementation FNStoreBiInfoArrayModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"dataList":@"dataList"
             };
}

+ (NSValueTransformer *)dataListJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:FNStoreBiInfoModel.class];
}

@end

//首页数据报表

@implementation FNStoreBiInfoModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"code":@"code",
             @"name":@"name",
             @"data":@"data"
             };
}

@end




//dataArray层

@implementation FNStoreDsrInfoArrayModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"dataList":@"dataList"
             };
}

+ (NSValueTransformer *)dataListJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:FNStoreDsrInfoModel.class];
}

@end

//店铺评分数据

@implementation FNStoreDsrInfoModel

//- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError **)error;
//{
//    if (self = [super initWithDictionary:dictionaryValue error:error]) {
//        NSMutableAttributedString *rateNameString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@：%@",self.name,self.data]];
//        [rateNameString addAttribute:NSForegroundColorAttributeName value:GrayStringColor range:NSMakeRange(0, self.name.length +1)];
//        [rateNameString addAttribute:NSForegroundColorAttributeName value:BlackStringColor range:NSMakeRange(self.name.length +1, self.data.length)];
//        self.rateData = [rateNameString copy];
//    }
//    return self;
//}

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    
    return @{
             @"name":@"name",
             @"data":@"data",
             @"than":@"than",
             @"rate":@"rate"
             };
}

@end


//dataArray层
@implementation FNStoreManagementInfoArrayModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"dataList":@"dataList"
             };
}

+ (NSValueTransformer *)dataListJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:FNStoreManagementInfoModel.class];
}

@end
// 首页厂商管理
@implementation FNStoreManagementInfoModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"code":@"code",
             @"name":@"name",
             @"url":@"url",
             @"iconImageUrl":@"iconImageUrl"
             };
}

@end




@implementation FNHomeInfoModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"store": @"body.store",
             @"bi" :@"body.bi",
             @"dsr" :@"body.dsr",
             @"manage" :@"body.manage",
             };
    
}

+ (NSValueTransformer *)biJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:FNStoreBiInfoArrayModel.class];
}

+ (NSValueTransformer *)dsrJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:FNStoreDsrInfoArrayModel.class];
}

+ (NSValueTransformer *)manageJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:FNStoreManagementInfoArrayModel.class];
}

+(NSValueTransformer *)storeJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:FNStoreInfoModel.class];
}
@end

