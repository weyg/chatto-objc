//
//  VIOSLayoutAttributesItemObject.m
//  MessagesCollectionView
//
//  Created by Aziz Latypov on 18/03/16.
//  Copyright © 2016 Aziz Latypov. All rights reserved.
//

#import "VIOSLayoutAttributesItemObject.h"

@implementation VIOSLayoutAttributesItemObject

- (instancetype)init
{
    return [self initWithCenter:CGPointZero size:CGSizeZero];
}

- (instancetype)initWithCenter:(CGPoint)center size:(CGSize)size {
    return [self initWithCenter:center size:size items:nil];
}

- (instancetype)initWithCenter:(CGPoint)center size:(CGSize)size items:(NSArray <id<VIOSLayoutAttributesItem>> *)items;
{
    self = [super init];
    if (self) {
        _size = size;
        _center = center;
        _items = items;
    }
    return self;
}

#pragma mark -

- (BOOL)isEqual:(id)object {
    if (![object conformsToProtocol:@protocol(VIOSLayoutAttributesItem)]) {
        return NO;
    }
    id<VIOSLayoutAttributesItem> otherObject = object;
    CGSize otherSize = [otherObject size];
    CGPoint otherCenter = [otherObject center];
    BOOL equalBounds = memcmp((void*)&_size, (void*)&otherSize, sizeof(CGSize)) == 0;
    BOOL equalCenters = memcmp((void*)&_center, (void*)&otherCenter, sizeof(CGPoint)) == 0;
    BOOL equalItems = YES;
    for (NSInteger i=0; i<self.items.count; i++) {
        id<VIOSLayoutAttributesItem> item = [self.items objectAtIndex:i];
        id<VIOSLayoutAttributesItem> otherItem = [[otherObject items] objectAtIndex:i];
        if (![item isEqual:otherItem]) {
            equalItems = NO;
            break;
        }
    }
    return equalBounds && equalCenters && equalItems;
}

#pragma mark - Debug -

- (NSString *)description {
    return [NSString stringWithFormat:@"size: (w: %0.2lf, h: %0.2lf), center: (x: %0.2lf, y: %0.2lf), item count: %ld", _size.width, _size.height, _center.x, _center.y, (long)_items.count];
}

- (NSString *)debugDescription {
    return [self debugDescriptionWithLevel:0];
}

- (NSString *)debugDescriptionWithLevel:(NSInteger)level {
    NSString *selfDescription = [self description];
    NSMutableArray *itemsDescriptions = [NSMutableArray new];
    NSString *preffix = @"--";
    if (level>0) {
        for (NSInteger l=0; l<level; l++) {
            preffix = [preffix stringByAppendingString:@"--"];
        }
    }
    for(NSInteger i = 0; i<self.items.count; i++) {
        NSString *childDescription = [(VIOSLayoutAttributesItemObject*)[self.items objectAtIndex:i] debugDescriptionWithLevel:level+1]; // recursive call
        NSString *shiftedDescription = [preffix stringByAppendingString:childDescription];
        [itemsDescriptions addObject:shiftedDescription];
    }
    if (itemsDescriptions.count > 0) {
        NSString *childrenDescription = [itemsDescriptions componentsJoinedByString:@"\n"];
        selfDescription = [[selfDescription stringByAppendingString:@"\n"] stringByAppendingString:childrenDescription];
    }
    return selfDescription;
}

@end