//
//  FNStoreCollectionViewCell.h
//  FNMerchant
//
//  Created by 张苏亚 on 16/6/20.
//  Copyright © 2016年 FeiNiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FNStoreCollectionViewCell : UICollectionViewCell

@property (nonatomic, assign) BOOL hidenIcon;

@property (nonatomic, strong) UIImage *iconImage;

//@property (nonatomic, strong) UILabel *nameLabel;
//@property (nonatomic, strong) UILabel *dataLabel;
@property (nonatomic, strong) UIButton *iconView;

//-(void)initConstraints;

-(void)iconViewClicked;
@end
