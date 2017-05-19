//
//  MDStoreBiInfoCollectionViewCell.m
//  MarkDemo
//
//  Created by 张苏亚 on 16/5/31.
//  Copyright © 2016年 张苏亚. All rights reserved.
//

#import "FNStoreBiInfoCollectionViewCell.h"


@interface FNStoreBiInfoCollectionViewCell ()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *dataLabel;

@property (nonatomic, assign) BOOL firstSetIconHidden;
@end

@implementation FNStoreBiInfoCollectionViewCell

#pragma mark - Lifecycle

-(instancetype)init
{
    if (self = [super init]) {
        [self initialization];
    }
    return self;
}

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
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.dataLabel];
    [self.contentView addSubview:self.iconView];

    self.backgroundColor = [UIColor whiteColor];
    
    
    [self initConstraints];
//    [self.iconView setEnlargeEdgeWithTop:0 right:0 bottom:20 left:20];
    _firstSetIconHidden = YES;
    self.hidenIcon = YES;
    
}


#pragma mark - Custom Accessors

-(UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        [_nameLabel setTextAlignment:NSTextAlignmentCenter];
        [_nameLabel setFont: [UIFont systemFontOfSize:12]];
        [_nameLabel setTextColor:GreenBackgroundColor];
    }
    return _nameLabel;
}

-(UILabel *)dataLabel
{
    if (!_dataLabel) {
        _dataLabel = [[UILabel alloc] init];
        [_dataLabel setTextAlignment:NSTextAlignmentCenter];
        [_dataLabel setFont:[UIFont systemFontOfSize:18]];
        [_dataLabel setTextColor:BlackStringColor];
    }
    return _dataLabel;
}

- (void)setBiInfoModel:(FNStoreBiInfoModel *)biInfoModel
{
    _biInfoModel = biInfoModel;
    
    if (biInfoModel.name) {
        [self.nameLabel setText:biInfoModel.name];
    }else
    {
        [self.nameLabel setText:@""];
    }
    
    if (biInfoModel.data) {
        [self.dataLabel setText:biInfoModel.data];
    }else
    {
        [self.dataLabel setText:@""];
    }
    
    
    
}


+ (BOOL)requiresConstraintBasedLayout
{
    return YES;
}

//overrider
- (void)setHidenIcon:(BOOL)hidenIcon
{
    [super setHidenIcon:hidenIcon];
    // tell constraints they need updating
    if (_firstSetIconHidden) {
        
        _firstSetIconHidden = NO;
        
    }else
    {
        [self setNeedsUpdateConstraints];
        
        // update constraints now so we can animate the change
        [self updateConstraintsIfNeeded];
        
//        [UIView animateWithDuration:0.4 animations:^{
            [self layoutIfNeeded];
//        }];
    }
    

//    [self updateConstraintsByHidden:hidenIcon];
}
#pragma mark - Private

-(void)initConstraints
{
    CGFloat padding = 6;
    
    CGFloat iconWidht = 14.5f;
    
    UIView *superview = self.contentView;
    
    FNStoreBiInfoCollectionViewCell *superSuperView = self;
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.greaterThanOrEqualTo(superview.mas_top).offset(15);
        make.left.equalTo(superview.mas_left).offset(0);
        make.bottom.equalTo(superSuperView.dataLabel.mas_top).offset(-8);
        make.right.equalTo(superview.mas_right).offset(0);
        make.height.equalTo(@(12));
//        make.width.equalTo(superview.mas_width).offset(0);
        
    }];
    
    
    [self.dataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superSuperView.nameLabel.mas_bottom).offset(8);
        make.left.equalTo(superview.mas_left);
        make.bottom.equalTo(superview.mas_bottom).offset(-10);
        make.right.equalTo(superview.mas_right);
        make.height.equalTo(@(18));
//        make.height.equalTo(superview.height); //can pass array of attributes
    }];
    

    //with is semantic and option
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superview.mas_top).with.offset(padding); //with with
        make.left.equalTo(superview.mas_right).offset(-padding -iconWidht); //without with

        make.width.offset(iconWidht);
        make.height.offset(iconWidht);

    }];
}
#pragma mark - actions


-(void)updateConstraints
{
    CGFloat padding = 6;
    
    CGFloat iconWidht = 14.5f;
    
    UIView *superview = self.contentView;
    
//    FNStoreBiInfoCollectionViewCell *superSuperView = self;

    if (self.hidenIcon) {
        
        [self.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.top.greaterThanOrEqualTo(superview.mas_top).offset(15);
            make.left.equalTo(superview.mas_left);
//            make.bottom.equalTo(superSuperView.dataLabel.mas_top).offset(-10);
            make.right.equalTo(superview.mas_right);
//            make.width.lessThanOrEqualTo(superview.mas_width).offset(0);
            
        }];
        
 
        
    }else
    {
        [self.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.top.greaterThanOrEqualTo(superview.mas_top).offset(15);
            make.left.equalTo(superview.mas_left).offset(padding + iconWidht);
//            make.bottom.equalTo(superSuperView.dataLabel.mas_top).offset(-10);
            make.right.equalTo(superview.mas_right).offset(-padding - iconWidht);
//            make.width.lessThanOrEqualTo(superview.mas_width).offset(-2*(padding + iconWidht));
            
        }];
        
        

        
    }
    
    [super updateConstraints];

    
}

- (void)iconViewClicked
{
//    if (self.topIconViewClickedOperationBlock) {
//        self.topIconViewClickedOperationBlock(self);
//    }
    
    if ([self.delegate respondsToSelector:@selector(iconViewClicked:)]) {
        [self.delegate iconViewClicked:self];
    }
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
}

@end
