//
//  NSSet+BlockKit.m
//  MessagesCollectionView
//
//  Created by Aziz Latypov on 23/03/16.
//  Copyright © 2016 Aziz Latypov. All rights reserved.
//

#import "NSSet+BlockKit.h"

@implementation NSSet (BlockKit)

- (NSSet *)bk_reject:(BOOL (^)(id obj))block
{
    NSParameterAssert(block != nil);
    
    return [self objectsPassingTest:^BOOL(id obj, BOOL *stop) {
        return !block(obj);
    }];
}

@end
