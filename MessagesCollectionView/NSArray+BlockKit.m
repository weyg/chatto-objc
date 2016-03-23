//
//  NSArray+BlockKit.m
//  MessagesCollectionView
//
//  Created by Aziz Latypov on 23/03/16.
//  Copyright © 2016 Aziz Latypov. All rights reserved.
//

#import "NSArray+BlockKit.h"

@implementation NSArray (BlockKit)

- (NSArray *)bk_map:(id (^)(id obj))block
{
    NSParameterAssert(block != nil);
    
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:self.count];
    
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        id value = block(obj) ?: [NSNull null];
        [result addObject:value];
    }];
    
    return result;
}

- (NSArray*)bk_filter:(BOOL(^)(id))filter
{
    NSParameterAssert(filter != nil);
    
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:self.count];
    
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        BOOL take = filter(obj);
        if (take) {
            [result addObject:obj];
        }
    }];
    
    return result;
}

- (id)bk_reduce:(id)initial withBlock:(id (^)(id sum, id obj))block
{
    NSParameterAssert(block != nil);
    
    __block id result = initial;
    
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        result = block(result, obj);
    }];
    
    return result;
}

@end
