//
//  LayoutSourceItemStub.m
//  MessagesCollectionView
//
//  Created by Aziz Latypov on 21/03/16.
//  Copyright © 2016 Aziz Latypov. All rights reserved.
//

#import "LayoutSourceItemStub.h"

@interface LayoutSourceItemStub ()

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGFloat absoluteHeight;
@property (nonatomic, assign) CGFloat cachedWidth;
@property (nonatomic, assign) BOOL cachedHeight;

@property (nonatomic, strong) NSArray <id<VIOSLayoutSourceItem>>* items;

@end

@implementation LayoutSourceItemStub

- (CGFloat)heightWithFixedWidth:(CGFloat)fixedWidth {
    return _height;
}

- (CGFloat)absoluteHeightWithFixedWidth:(CGFloat)fixedWidth {
    if (!_cachedHeight || fabs(_absoluteHeight)<0.001 || fabs(_cachedWidth - fixedWidth) > 1) {
        CGFloat h = _height;
        for (NSInteger i = 0; i< self.items.count; i++) {
            id<VIOSLayoutSourceItem> it = [self.items objectAtIndex:i];
            h += [it absoluteHeightWithFixedWidth:fixedWidth];
        }
        _cachedWidth = fixedWidth;
        _absoluteHeight = h;
        _cachedHeight = YES;
    }
    return _absoluteHeight;
}

#pragma mark - Init -

- (instancetype)initWithHeight:(CGFloat)height
{
    return [self initWithHeight:height items:nil];
}

- (instancetype)initWithHeight:(CGFloat)height items:(NSArray <id<VIOSLayoutSourceItem>>*)items
{
    self = [super init];
    if (self) {
        _height = height;
        _items = items;
    }
    return self;
}

@end
