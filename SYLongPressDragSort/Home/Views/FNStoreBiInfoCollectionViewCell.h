//
//  MDStoreBiInfoCollectionViewCell.h
//  MarkDemo
//
//  Created by 张苏亚 on 16/5/31.
//  Copyright © 2016年 张苏亚. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNHomeInfoModel.h"
#import "FNStoreCollectionViewCell.h"
@class FNStoreBiInfoCollectionViewCell;

@protocol FNStoreBiInfoCollectionViewCellDelegate <NSObject>

@optional
//iconView点击
-(void)iconViewClicked:(FNStoreBiInfoCollectionViewCell *)cell;

@end

@interface FNStoreBiInfoCollectionViewCell : FNStoreCollectionViewCell




@property (nonatomic, strong) FNStoreBiInfoModel *biInfoModel;

@property (nonatomic, assign) id<FNStoreBiInfoCollectionViewCellDelegate> delegate;
//@property (nonatomic, copy) void (^topItemLongPressedOperationBlock)(UILongPressGestureRecognizer *longPressed);
//@property (nonatomic, copy) void (^topButtonClickedOperationBlock)(MDStoreBiInfoCollectionViewCell *item);
@property (nonatomic, copy) void (^topIconViewClickedOperationBlock)(FNStoreBiInfoCollectionViewCell *item);

@end
