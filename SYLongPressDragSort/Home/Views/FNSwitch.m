//
//  FNSwitch.m
//  FNMerchant
//
//  Created by 张苏亚 on 16/8/29.
//  Copyright © 2016年 FeiNiu. All rights reserved.
//

#import "FNSwitch.h"

@interface FNSwitch(){
    BOOL previousValue;
}
@end

@implementation FNSwitch



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        previousValue = self.isOn;
    }
    return self;
}


-(void)awakeFromNib{
    [super awakeFromNib];
    previousValue = self.isOn;
    self.exclusiveTouch = YES;
}


- (void)setOn:(BOOL)on animated:(BOOL)animated{
    
    [super setOn:on animated:animated];
    previousValue = on;
}


-(void)sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
    
    if(previousValue != self.isOn){
        for (id targetForEvent in [self allTargets]) {
            for (id actionForEvent in [self actionsForTarget:targetForEvent forControlEvent:UIControlEventValueChanged]) {
                [super sendAction:NSSelectorFromString(actionForEvent) to:targetForEvent forEvent:event];
            }
        }
        previousValue = self.isOn;
        return;
    }
}

@end
