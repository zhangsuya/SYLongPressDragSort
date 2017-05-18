//
//  FNHomeViewModel.m
//  FNMerchant
//
//  Created by 张苏亚 on 16/6/17.
//  Copyright © 2016年 FeiNiu. All rights reserved.
//

#import "FNHomeViewModel.h"
#import "FNHomeInfoModel.h"

@implementation FNHomeViewModel


#pragma mark - Lifecycle

-(instancetype)init
{
    if (self = [super init]) {
        
        _biInfoArray = @[].mutableCopy;
        _modelInfoArray = @[].mutableCopy;
        _dsrInfoArray = @[].mutableCopy;
        _cellSizeArrray = @[].mutableCopy;
        _headerSizeArray = @[].mutableCopy;
        _footerSizeArray = @[].mutableCopy;
    }
    
    return self;
}

-(void)calculateLayoutInfo
{
    [self calculateCellInfo];
    [self calculateHeaderSize];
    [self calculateFooterSize];
    
}

-(void)calculateCellInfo
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setRoundingMode:NSNumberFormatterRoundFloor];
    [formatter setMaximumFractionDigits:1];
    
    NSNumber *number =  [NSNumber numberWithFloat:(kScreenWidth  / 3.0) - 0.5f];
    
    for (int i = 0 ; i < 3 ; i ++) {
        if (i == 0) {
            [self.cellSizeArrray addObject:[NSValue valueWithCGSize:CGSizeMake([number floatValue], 64 )]];
        }else if (i == 1)
        {
            [self.cellSizeArrray addObject:[NSValue valueWithCGSize:CGSizeMake(kScreenWidth, 24.5f)]];
        }else if (i == 2)
        {
            [self.cellSizeArrray addObject:[NSValue valueWithCGSize:CGSizeMake(kScreenWidth / 4.0, 97)]];
            
        }
        
        
    }
    
    for (int i = 0 ; i< [self.dsrInfoArray count]; i ++) {
        FNStoreDsrInfoModel *dsrInfoModel = self.dsrInfoArray[i];
        
        NSMutableAttributedString *rateNameString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@：%@",dsrInfoModel.name,dsrInfoModel.data]];
//        [rateNameString addAttribute:NSForegroundColorAttributeName value:[UIColor fn_color:FNColor_medium_grey] range:NSMakeRange(0, dsrInfoModel.name.length +1)];
//        [rateNameString addAttribute:NSForegroundColorAttributeName value:[UIColor fn_color:FNColor_black] range:NSMakeRange(dsrInfoModel.name.length +1, dsrInfoModel.data.length)];
        dsrInfoModel.rateData = [rateNameString copy];
        
    }
}

-(void)calculateHeaderSize
{
    
    for (int i = 0 ; i < 3 ; i ++) {
        if (i == 0) {
            [self.headerSizeArray addObject:[NSValue valueWithCGSize:CGSizeZero]];
        }else if (i == 1)
        {
            [self.headerSizeArray addObject:[NSValue valueWithCGSize:CGSizeMake(kScreenWidth, 34)]];
        }else if (i == 2)
        {
            [self.headerSizeArray addObject:[NSValue valueWithCGSize:CGSizeMake(kScreenWidth, 10)]];
            
        }
        
        
    }
}

-(void)calculateFooterSize
{
    
    for (int i = 0 ; i < 3 ; i ++) {
        if (i == 0) {
            [self.footerSizeArray addObject:[NSValue valueWithCGSize:CGSizeMake(kScreenWidth, 9)]];
        }else if (i == 1)
        {
            [self.footerSizeArray addObject:[NSValue valueWithCGSize:CGSizeMake(kScreenWidth, 9 +5)]];
        }else if (i == 2)
        {
            [self.footerSizeArray addObject:[NSValue valueWithCGSize:CGSizeMake(kScreenWidth, 10)]];
            
        }
        
        
    }
    
}

#pragma mark - Custom Accessors
-(FNStoreManagementInfoModel *)lastManagementInfoModel
{
    if (!_lastManagementInfoModel) {
        NSDictionary *managementDict = @{
                                         @"name":@"设置",
                                         @"url":@"icon_setup"
                                         };
        _lastManagementInfoModel = [MTLJSONAdapter modelOfClass:[FNStoreManagementInfoModel class] fromJSONDictionary:managementDict error:nil];
    }
    return _lastManagementInfoModel;
}


@end
