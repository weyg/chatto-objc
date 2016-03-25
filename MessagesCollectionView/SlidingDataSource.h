//
//  SlidingDataSource.h
//  MessagesCollectionView
//
//  Created by Aziz Latypov on 25/03/16.
//  Copyright © 2016 Aziz Latypov. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    InsertPositionTop,
    InsertPositionBottom,
} InsertPositionType;

@interface SlidingDataSource : NSObject

@property (assign, nonatomic) NSInteger pageSize;
@property (assign, nonatomic) NSInteger windowOffset;
@property (assign, nonatomic) NSInteger windowCount;
@property (strong, nonatomic) NSMutableArray *items;
@property (assign, nonatomic) NSInteger itemsOffset;
@property (readonly, nonatomic) NSArray *itemsInWindow;

- (instancetype)initWithItems:(NSArray*)items pageSize:(NSInteger)pageSize;

- (void)insertItem:(id)item position:(InsertPositionType)position;
- (BOOL)hasPrevious;
- (BOOL)hasMore;
- (void)loadPrevios;
- (void)loadNext;
- (void)clean;
- (BOOL)adjustWindowWithFocusPosition:(double)focusPosition maxWindowSize:(NSInteger)maxWindowSize;

- (void)generateItems:(NSInteger)messagesNeeded postion:(InsertPositionType)position;

@end
