//
//  FNStoreCollectionViewCell.m
//  FNMerchant
//
//  Created by 张苏亚 on 16/6/20.
//  Copyright © 2016年 FeiNiu. All rights reserved.
//

#import "FNStoreCollectionViewCell.h"
@interface FNStoreCollectionViewCell()


@end

@implementation FNStoreCollectionViewCell


#pragma mark - Custom Accessors



-(UIButton *)iconView
{
    if (!_iconView) {
        _iconView = [[UIButton alloc] init];
        [_iconView setImage:[UIImage imageNamed:@"icon_close_01"] forState:UIControlStateNormal];
        [_iconView addTarget:self action:@selector(iconViewClicked) forControlEvents:UIControlEventTouchUpInside];
        _iconView.hidden = YES;
        _iconView.enabled = NO;
        _iconView.userInteractionEnabled = NO;
        _iconView.exclusiveTouch = YES;
    }
    return _iconView;
}


- (void)setHidenIcon:(BOOL)hidenIcon
{
    _hidenIcon = hidenIcon;
    _iconView.hidden = hidenIcon;
    _iconView.enabled = !hidenIcon;
    _iconView.userInteractionEnabled = !hidenIcon;

    if (hidenIcon == NO) {
//        self.backgroundColor = [UIColor fn_color:FNColor_background_color];
    }else
    {
        self.backgroundColor = [UIColor whiteColor];
    }
}

- (void)setIconImage:(UIImage *)iconImage
{
    _iconImage = iconImage;
    
    [_iconView setImage:iconImage forState:UIControlStateNormal];
}

#pragma mark - public



-(void)iconViewClicked
{
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
}

@end
