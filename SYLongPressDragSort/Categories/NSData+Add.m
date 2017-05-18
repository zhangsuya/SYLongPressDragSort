//
//  NSData+Add.m
//  SYLongPressDragSort
//
//  Created by 张苏亚 on 17/5/18.
//  Copyright © 2017年 张苏亚. All rights reserved.
//

#import "NSData+Add.h"

@implementation NSData (Add)
+ (NSData *)dataNamed:(NSString *)name {
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@""];
    if (!path) return nil;
    NSData *data = [NSData dataWithContentsOfFile:path];
    return data;
}
@end
