//
//  BMAChatDataSourceProtocol.h
//  MessagesCollectionView
//
//  Created by Aziz Latypov on 23/03/16.
//  Copyright © 2016 Aziz Latypov. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BMAChatUpdateType.h"
#import "BMAChatItemProtocol.h"

@protocol BMAChatDataSourceProtocol;

@protocol BMAChatDataSourceDelegateProtocol
- (void)chatDataSourceDidUpdate:(id<BMAChatDataSourceProtocol>)chatDataSource context:(BMAChatUpdateType)context;
@end

@protocol BMAChatDataSourceProtocol

- (BOOL)hasMoreNext;
- (BOOL)hasMorePreBMA;
@property (nonatomic, readonly) NSArray <id<BMAChatItemProtocol>> *chatItems;
@property (nonatomic, weak) id<BMAChatDataSourceDelegateProtocol> delegate;

- (void)loadNext:(void(^)())completion;
- (void)loadPrevious:(void(^)())completion;
- (void)adjustNumberOfMessagesToPreferredMaxCount:(NSInteger)preferredMaxCount focusPosition:(double)focusPosition completion:(void(^)(BOOL didAdjust))completion;

@end