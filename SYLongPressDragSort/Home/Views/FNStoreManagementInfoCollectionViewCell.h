//
//  FNStoreBiModelInfoCollectionViewCell.h
//  SYLongPressDragSort
//
//  Created by 张苏亚 on 16/5/31.
//  Copyright © 2016年 张苏亚. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNHomeInfoModel.h"
#import "FNStoreCollectionViewCell.h"

@class FNStoreManagementInfoCollectionViewCell;

@protocol FNStoreManagementInfoCollectionViewCellDelegate <NSObject>

@optional
//iconView点击
-(void)storeManagementInfoCellIconViewClicked:(FNStoreManagementInfoCollectionViewCell *)cell;
//self 点击
-(void)managementInfoCellClicked:(FNStoreManagementInfoCollectionViewCell *)cell;


@end

@interface FNStoreManagementInfoCollectionViewCell : FNStoreCollectionViewCell


@property (nonatomic,strong) FNStoreManagementInfoModel *modelInfoModel;

@property (nonatomic,strong) UILabel *nameLabel;

@property (nonatomic, assign) id<FNStoreManagementInfoCollectionViewCellDelegate> delegate;
@end
