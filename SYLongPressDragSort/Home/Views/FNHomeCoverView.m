//
//  FNHomeCoverView.m
//  FNMerchant
//
//  Created by 张苏亚 on 16/6/28.
//  Copyright © 2016年 suya. All rights reserved.
//

#import "FNHomeCoverView.h"

@interface FNHomeCoverView()

@property (nonatomic, strong) UIImageView *lineImageView;
@property (nonatomic, strong) UIImageView *descImageView;
@property (nonatomic, strong) UIButton *okBtn;

@end

@implementation FNHomeCoverView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark - Lifecycle

-(instancetype)init
{
    self = [super init];
    if (self) {
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close)];
        [self addGestureRecognizer:tapGes];
    }
    
    return self;
}

#pragma mark - Custom Accessors


-(UIImageView *)lineImageView
{
    if (!_lineImageView) {
        _lineImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_cover_line_ts"]];
        _lineImageView.frame = CGRectZero;
    }
    
    return _lineImageView;
}

-(UIImageView *)descImageView
{
    if (!_descImageView) {
        _descImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_cover_desc"]];
        _descImageView.frame = CGRectZero;
    }
    
    return _descImageView;
}

-(UIButton *)okBtn
{
    if (!_okBtn) {
        _okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_okBtn setImage:[UIImage imageNamed:@"home_cover_button"] forState:UIControlStateNormal];
        [_okBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        _okBtn.frame = CGRectZero;
    }
    return _okBtn;
}

#pragma mark - public

-(void)show
{
    
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    
    [self addSubview:self.lineImageView];
    [self addSubview:self.descImageView];
    [self addSubview:self.okBtn];

    //渐变显示
//    self.backgroundColor = [UIColor fn_color:FNColor_black alpha:0.5f];
    
//    self.alpha = 0.5f;
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    [self initConstraints];
}



-(void)close
{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - private

-(void)initConstraints
{
    UIView *superSuperView = self.superview;
    FNHomeCoverView *superview = self;
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superSuperView.mas_top);
        make.bottom.equalTo(superSuperView.mas_bottom);
        make.left.equalTo(superSuperView.mas_left);
        make.right.equalTo(superSuperView.mas_right);
    }];
    
    
    [self.lineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(superview.mas_centerX);
        make.top.equalTo(superview.mas_top).offset(75);
        make.bottom.equalTo(superview.descImageView.mas_top).offset(-14);
    }];
    
    [self.descImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(superview.mas_centerX);
        make.top.equalTo(superview.lineImageView.mas_bottom).offset(14);
        make.bottom.equalTo(superview).offset(-kScreenHeight + [UIImage imageNamed:@"home_cover_desc"].size.height +[UIImage imageNamed:@"home_cover_line_ts"].size.height + 75 + 14);
        make.width.equalTo(@([UIImage imageNamed:@"home_cover_desc"].size.width));
        make.height.equalTo(@([UIImage imageNamed:@"home_cover_desc"].size.height));
    }];
    
    if (kScreenHeight < 568.0) {//4s或更低
        [self.okBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(superview.mas_centerX);
            make.top.lessThanOrEqualTo(superview).offset(kScreenHeight - 146/2 - [UIImage imageNamed:@"home_cover_button"].size.width);
            make.bottom.equalTo(superview.mas_bottom).offset(-146/2);
        }];
    }else
    {
        [self.okBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(superview.mas_centerX);
            make.top.lessThanOrEqualTo(superview).offset(kScreenHeight - 146 - [UIImage imageNamed:@"home_cover_button"].size.width);
            make.bottom.equalTo(superview.mas_bottom).offset(-146);
        }];
    }
    
    
//    [self.lineImageView setContentCompressionResistancePriority:UILayoutPriorityRequired
//                                          forAxis:UILayoutConstraintAxisVertical];
}

@end
