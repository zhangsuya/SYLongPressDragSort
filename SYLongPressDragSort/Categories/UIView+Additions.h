//
//  UIView+Additions.h
//  jkcarddemo
//
//  Created by wangweishun@pajk.cn on 4/17/14.
//  Copyright (c) 2014 PAJK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Additions)

@property (nonatomic) CGFloat fleft;
@property (nonatomic) CGFloat ftop;
@property (nonatomic) CGFloat fright;
@property (nonatomic) CGFloat fbottom;
@property (nonatomic) CGFloat fwidth;
@property (nonatomic) CGFloat fheight;

@property (nonatomic) CGFloat fcenterX;
@property (nonatomic) CGFloat fcenterY;

@property (nonatomic) CGPoint forigin;
@property (nonatomic) CGSize fsize;

@property (nonatomic, retain) UIColor *borderColor;

@property (nonatomic, readonly) UIViewController *viewController;

+ (instancetype) drawDottedLineWithFrame:(CGRect)frame;

+ (UINib *)nib;
+ (NSString *)reuseIdentifier;
+ (void)registerNibForCellToTableView:(UITableView *)tableView;
+ (void)registerNibForHeaderFooterToTableView:(UITableView *)tableView;

- (void)centerInSuperView;
- (void)aestheticCenterInSuperView;

- (UIImage *)imageForView;

@end
