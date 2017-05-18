//
//  MDStoreAddBiInfoCollectionViewCell.m
//  MarkDemo
//
//  Created by 张苏亚 on 16/6/15.
//  Copyright © 2016年 张苏亚. All rights reserved.
//

#import "FNStoreAddBiInfoCollectionViewCell.h"

@implementation FNStoreAddBiInfoCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.exclusiveTouch = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellClicked)];
    tap.numberOfTouchesRequired = 1;
    tap.numberOfTapsRequired = 1;
    tap.cancelsTouchesInView = YES;
    [self addGestureRecognizer:tap];
    // Initialization code
}


-(void)cellClicked
{
    if ([self.delegate respondsToSelector:@selector(biInfoCellClicked:)]) {
        [self.delegate biInfoCellClicked:self];
    }
}

@end
