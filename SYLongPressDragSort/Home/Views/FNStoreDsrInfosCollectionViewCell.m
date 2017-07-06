//
//  FNNewStoreBiDsrInfosCollectionViewCell.m
//  SYLongPressDragSort
//
//  Created by 张苏亚 on 16/6/15.
//  Copyright © 2016年 张苏亚. All rights reserved.
//

#import "FNStoreDsrInfosCollectionViewCell.h"

@interface FNStoreDsrInfosCollectionViewCell()

@property (weak, nonatomic) IBOutlet UILabel *storeDsrRateLabel;
@property (weak, nonatomic) IBOutlet UILabel *storeDsrThanLabel;
@property (weak, nonatomic) IBOutlet UIImageView *storeDsrThanImageView;

@property (weak, nonatomic) IBOutlet UILabel *storeDsrThanImageLabel;

@end


@implementation FNStoreDsrInfosCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

#pragma mark - Custom Accessors

-(void)setDsrInfoModel:(FNStoreDsrInfoModel *)dsrInfoModel
{
    _dsrInfoModel = dsrInfoModel;
    
    [_storeDsrThanImageLabel setText:dsrInfoModel.than];
    
    if ([dsrInfoModel.than isEqualToString:@"高于"]) {
        [_storeDsrThanImageView setImage:[UIImage imageNamed:@"icon_up"]];
    }else if ([dsrInfoModel.than isEqualToString:@"低于"])
    {
        [_storeDsrThanImageView setImage:[UIImage imageNamed:@"icon_dow"]];
    }else if ([dsrInfoModel.than isEqualToString:@"持平"])
    {
        [_storeDsrThanImageView setImage:[UIImage imageNamed:@"icon_flat"]];
    }else
    {//默认持平
        [_storeDsrThanImageView setImage:[UIImage imageNamed:@"icon_flat"]];
    }
    
    [_storeDsrThanLabel setAttributedText:dsrInfoModel.rateData];
    [_storeDsrRateLabel setText:dsrInfoModel.rate];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
}

@end
