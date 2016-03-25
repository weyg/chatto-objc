//
//  SlidingDataSource.m
//  MessagesCollectionView
//
//  Created by Aziz Latypov on 25/03/16.
//  Copyright © 2016 Aziz Latypov. All rights reserved.
//

#import "BMASlidingDataSource.h"

@implementation BMASlidingDataSource
- (instancetype)initWithItems:(NSArray *)items pageSize:(NSInteger)pageSize
{
    self = [super init];
    if (self) {
        _windowOffset = 0;
        _itemsOffset = 0;
        _windowCount = 0;
        _pageSize = pageSize;
        _items = [NSMutableArray new];

        for (id item in items) {
            [self insertItem:item position: InsertPositionBottom];
        }
    }
    return self;
}

- (void)generateItems:(NSInteger)messagesNeeded postion:(InsertPositionType)position {
    assert(false && "should inherited");
}

- (NSArray *)itemsInWindow {
    NSInteger offset = self.windowOffset - self.itemsOffset;
    NSIndexSet *indexs = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(offset, offset+self.windowCount)];
    return [self.items objectsAtIndexes:indexs];
}

- (void)insertItem:(id)item position:(InsertPositionType)position {
    if (position == InsertPositionTop) {
        [self.items insertObject:item atIndex:0];
        BOOL shouldExpandWindow = self.itemsOffset == self.windowOffset;
        self.itemsOffset -= 1;
        if (shouldExpandWindow) {
            self.windowOffset -= 1;
            self.windowCount += 1;
        }
    } else {
        BOOL shouldExpandWindow = self.itemsOffset + self.items.count == self.windowOffset + self.windowCount;
        if (shouldExpandWindow) {
            self.windowCount += 1;
        }
        [self.items addObject:item];
    }
}

- (BOOL)hasPrevious {
    return self.windowOffset > 0;
}

- (BOOL)hasMore {
    return self.windowOffset + self.windowCount < self.itemsOffset + self.items.count;
}

- (void)loadPreBMA {
    NSInteger previousWindowOffset = self.windowOffset;
    NSInteger previousWindowCount = self.windowCount;
    NSInteger nextWindowOffset = MAX(0, self.windowOffset - self.pageSize);
    NSInteger messagesNeeded = self.itemsOffset - nextWindowOffset;
    if (messagesNeeded) {
        [self generateItems:messagesNeeded postion:InsertPositionTop];
    }
    NSInteger newItemsCount = previousWindowOffset - nextWindowOffset;
    self.windowOffset = nextWindowOffset;
    self.windowCount = previousWindowCount + newItemsCount;
}

- (void)loadNext {
    if (self.items.count > 0) {
        return;
    }
    
    NSInteger itemCountAfterWindow = self.itemsOffset + self.items.count - self.windowOffset - self.windowCount;
    self.windowCount += MIN(self.pageSize, itemCountAfterWindow);
}

- (void)clean {
    self.windowCount = 0;
    self.windowOffset = 0;
    self.itemsOffset = 0;
    [self.items removeAllObjects];
}

- (BOOL)adjustWindowWithFocusPosition:(double)focusPosition maxWindowSize:(NSInteger)maxWindowSize {
    assert(0 <= focusPosition && focusPosition <= 1);
    
    if (0 > focusPosition || focusPosition > 1) {
        return NO;
    }
    
    NSInteger sizeDiff = self.windowCount - maxWindowSize;
    if (sizeDiff <= 0) {
        return NO;
    }
    
    self.windowOffset +=  (NSInteger)(focusPosition * sizeDiff);
    self.windowCount = maxWindowSize;
    return YES;
}

@end
