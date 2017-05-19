//
//  MDStoreDsrInfoHeaderReusableView.m
//  MarkDemo
//
//  Created by 张苏亚 on 16/6/2.
//  Copyright © 2016年 张苏亚. All rights reserved.
//

#import "FNStoreDsrInfoHeaderReusableView.h"
//#import "MDMacros.h"

@interface FNStoreDsrInfoHeaderReusableView()

@property (weak, nonatomic) IBOutlet UILabel *storeDsrRateLabel;
@property (weak, nonatomic) IBOutlet UILabel *storeDsrThanLabel;

@end

@implementation FNStoreDsrInfoHeaderReusableView

#pragma mark - Lifecycle

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
}
@end
