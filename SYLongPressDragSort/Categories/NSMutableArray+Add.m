//
//  NSMutableArray+Add.m
//  SYLongPressDragSort
//
//  Created by 张苏亚 on 17/5/18.
//  Copyright © 2017年 张苏亚. All rights reserved.
//

#import "NSMutableArray+Add.h"

@implementation NSMutableArray (Add)
- (void)moveObjectFromIndex:(NSUInteger)from toIndex:(NSUInteger)to {
    if (to != from) {
        id obj = [self objectAtIndex:from];
        [self removeObjectAtIndex:from];
        
        if (to >= [self count]) {
            [self addObject:obj];
        } else {
            [self insertObject:obj atIndex:to];
        }
    }
}
@end
