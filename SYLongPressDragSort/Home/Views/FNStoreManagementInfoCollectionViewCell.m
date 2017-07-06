//
//  MDStoreBiModelInfoCollectionViewCell.m
//  MarkDemo
//
//  Created by 张苏亚 on 16/5/31.
//  Copyright © 2016年 张苏亚. All rights reserved.
//

#import "FNStoreManagementInfoCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
//#import "UIButton+EnlargeTouchArea.h"
@interface FNStoreManagementInfoCollectionViewCell ()

@property (nonatomic,strong) UIImageView *iconImageView;

@end

@implementation FNStoreManagementInfoCollectionViewCell

#pragma mark - Lifecycle

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initialization];
    }
    return self;
}

- (void)initialization
{
    self.userInteractionEnabled = YES;
    self.exclusiveTouch = YES;
    [self addSubview:self.iconImageView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.iconView];
    self.backgroundColor = [UIColor whiteColor];
    [self initConstraints];
//    [self.iconView setEnlargeEdgeWithTop:0 right:0 bottom:10 left:10];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellClicked)];
    tap.numberOfTouchesRequired = 1;
    tap.numberOfTapsRequired = 1;
    tap.cancelsTouchesInView = YES;
    [self addGestureRecognizer:tap];
//    self
}

#pragma mark - Custom Accessors

-(UIImageView *)iconImageView
{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        

    }
    return _iconImageView;
}


-(UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [_nameLabel setTextAlignment:NSTextAlignmentCenter];
        [_nameLabel setFont: [UIFont systemFontOfSize:12]];
//        [_nameLabel setTextColor:[UIColor fn_color:FNColor_light_grey]];
    }
    return _nameLabel;
}


-(void)setModelInfoModel:(FNStoreManagementInfoModel *)modelInfoModel
{
    _modelInfoModel = modelInfoModel;
    if (modelInfoModel.iconImageUrl) {
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:modelInfoModel.iconImageUrl] placeholderImage:[UIImage imageNamed:@"icon_comment"]];
    }else
    {
        [self.iconImageView setImage:[UIImage imageNamed:modelInfoModel.url]];
        
    }
    
    
    [self.nameLabel setText:modelInfoModel.name];
}



#pragma mark - Private

-(void)initConstraints
{
    UICollectionViewCell *superview = self;
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(superview.mas_centerX);
        make.centerY.equalTo(superview.mas_centerY).offset(-11.5);

    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.greaterThanOrEqualTo(superview.mas_top).offset(73);
        make.left.equalTo(superview.mas_left);
        make.bottom.equalTo(superview.mas_bottom).offset(-10);
        make.right.equalTo(superview.mas_right);
        make.width.equalTo(superview.mas_width);
        

    }];
    
    CGFloat padding = 6;
    
    CGFloat iconWidht = 14.5f;
    //with is semantic and option
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superview.mas_top).with.offset(padding); //with with
        make.left.equalTo(superview.mas_right).offset(-padding -iconWidht); //without with
        
        make.width.offset(iconWidht);
        make.height.offset(iconWidht);
        
    }];
}

#pragma mark - actions



- (void)iconViewClicked
{

    if ([self.delegate respondsToSelector:@selector(storeManagementInfoCellIconViewClicked:)]) {
        [self.delegate storeManagementInfoCellIconViewClicked:self];
    }
}

-(void)cellClicked
{
    
    
    if ([self.delegate respondsToSelector:@selector(managementInfoCellClicked:)]) {
        [self.delegate managementInfoCellClicked:self];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
}

@end
