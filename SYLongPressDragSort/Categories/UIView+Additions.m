
//
//  UIView+Additions.m
//  jkcarddemo
//
//  Created by wangweishun@pajk.cn on 4/17/14.
//  Copyright (c) 2014 PAJK. All rights reserved.
//

#import "UIView+Additions.h"

@implementation UIView (Additions)

- (CGFloat)fleft {
    return self.frame.origin.x;
}

- (void)setFleft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)ftop {
    return self.frame.origin.y;
}

- (void)setFtop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)fright {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setFright:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)fbottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setFbottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)fcenterX {
    return self.center.x;
}

- (void)setFcenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)fcenterY {
    return self.center.y;
}

- (void)setFcenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGFloat)fwidth {
    return self.frame.size.width;
}

- (void)setFwidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)fheight {
    return self.frame.size.height;
}

- (void)setFheight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGPoint)forigin {
    return self.frame.origin;
}

- (void)setForigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)fsize {
    return self.frame.size;
}

- (void)setFsize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (UIColor *)borderColor {
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

- (void)setBorderColor:(UIColor *)borderColor {
    self.layer.borderWidth = 1;
    self.layer.borderColor = [borderColor CGColor];
}

- (void)centerInSuperView {
    if (self.superview) {
        CGFloat xPos = roundf((self.superview.frame.size.width - self.frame.size.width) / 2.f);
        CGFloat yPos = roundf((self.superview.frame.size.height - self.frame.size.height) / 2.f);
        [self setForigin:CGPointMake(xPos, yPos)];
    }
}

- (void)aestheticCenterInSuperView {
    if (self.superview) {
        CGFloat xPos = roundf(([self.superview fwidth] - [self fwidth]) / 2.0);
        CGFloat yPos = roundf(([self.superview fheight] - [self fheight]) / 2.0) - ([self.superview fheight] / 8.0);
        [self setForigin:CGPointMake(xPos, yPos)];
    }
}

- (void)makeMarginInSuperViewWithTopMargin:(CGFloat)topMargin leftMargin:(CGFloat)leftMargin rightMargin:(CGFloat)rightMargin andBottomMargin:(CGFloat)bottomMargin {
    if (self.superview) {
        CGRect r = self.superview.bounds;
        r.origin.x = leftMargin;
        r.origin.y = topMargin;
        r.size.width -= (leftMargin + rightMargin);
        r.size.height -= (topMargin + bottomMargin);
        [self setFrame:r];
    }
}

- (void)makeMarginInSuperViewWithTopMargin:(CGFloat)topMargin andSideMargin:(CGFloat)sideMargin {
    if (self.superview) {
        [self makeMarginInSuperViewWithTopMargin:topMargin leftMargin:sideMargin rightMargin:sideMargin andBottomMargin:topMargin];
    }
}

- (void)makeMarginInSuperView:(CGFloat)margin {
    if (self.superview) {
        [self makeMarginInSuperViewWithTopMargin:margin andSideMargin:margin];
    }
}

- (UIImage *)imageForView {
    CGSize size = self.frame.size;
    UIGraphicsBeginImageContext(size);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIViewController *)viewController {
    for (UIView *next = self; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

+ (instancetype)drawDottedLineWithFrame:(CGRect)frame
{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    [view drawDottedLine];
    return view;
}

- (void)drawDottedLine {
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.fwidth, self.fheight)];
    [self addSubview:imageView];
    
    UIGraphicsBeginImageContext(imageView.frame.size);   //开始画线
    [imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);  //设置线条终点形状
    
    const CGFloat lengths[] = {4,4};
    CGContextRef line = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(line, [UIColor lightGrayColor].CGColor);
    
    CGContextSetLineDash(line, 0, lengths, 2);  //画虚线
    CGContextMoveToPoint(line, 0.0, self.fheight);    //开始画线
    CGContextAddLineToPoint(line, self.fwidth, self.fheight);
    CGContextStrokePath(line);
    
    imageView.image = UIGraphicsGetImageFromCurrentImageContext();
}

+ (UINib *)nib
{
    return [UINib nibWithNibName:[self reuseIdentifier] bundle:nil];
}

+ (NSString *)reuseIdentifier
{
    return NSStringFromClass([self class]);
}

+ (void)registerNibForCellToTableView:(UITableView *)tableView
{
    [tableView registerNib:[self nib] forCellReuseIdentifier:[self reuseIdentifier]];
}

+ (void)registerNibForHeaderFooterToTableView:(UITableView *)tableView
{
    [tableView registerNib:[self nib] forHeaderFooterViewReuseIdentifier:[self reuseIdentifier]];
}

@end















