//
//  FNStoreAddBiInfoCollectionViewCell.h
//  SYLongPressDragSort
//
//  Created by 张苏亚 on 16/6/15.
//  Copyright © 2016年 张苏亚. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FNStoreAddBiInfoCollectionViewCell;

@protocol FNStoreAddBiInfoCollectionViewCellDelegate <NSObject>

@optional

//self 点击
-(void)biInfoCellClicked:(FNStoreAddBiInfoCollectionViewCell *)cell;


@end

@interface FNStoreAddBiInfoCollectionViewCell : UICollectionViewCell

@property (nonatomic, assign) id<FNStoreAddBiInfoCollectionViewCellDelegate> delegate;


@end
