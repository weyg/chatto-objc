//
//  BMAFakeDataSource.m
//  MessagesCollectionView
//
//  Created by Latipov Aziz on 24/03/16.
//  Copyright © 2016 Aziz Latypov. All rights reserved.
//

#import "BMAFakeDataSource.h"

static NSInteger preferredMaxWindowSize = 500;
static NSInteger preferredPageSize = 50;

@interface ChatItemObject : NSObject <BMAChatItemProtocol>
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *type;
@end
@implementation ChatItemObject
@end

@interface BMAFakeDataSource ()
@property (nonatomic, assign) NSInteger lastID;
@end

@implementation BMAFakeDataSource

- (instancetype)init
{
    self = [super initWithItems:@[] pageSize:preferredPageSize];
    if (self) {
        _lastID = 0;
    }
    return self;
}

- (void)generateItems:(NSInteger)messagesNeeded postion:(InsertPositionType)position {
    
}

- (NSArray<id<BMAChatItemProtocol>> *)chatItems {
    return self.itemsInWindow;
}

- (BOOL)hasMoreNext {
    return [super hasMore];
}

- (BOOL)hasMorePreBMA {
    return [super hasPrevious];
}

- (void)loadNext:(void(^)())completion {
    [super loadNext];
    [super adjustWindowWithFocusPosition:1 maxWindowSize:preferredMaxWindowSize];
    completion();
}

- (void)loadPrevious:(void(^)())completion {
    [super loadPreBMA];
    [super adjustWindowWithFocusPosition:0 maxWindowSize:preferredMaxWindowSize];
    completion();
}

- (void)adjustNumberOfMessagesToPreferredMaxCount:(NSInteger)preferredMaxCount
                                    focusPosition:(double)focusPosition
                                       completion:(void(^)(BOOL didAdjust))completion
{
    BOOL didAdjust = [super adjustWindowWithFocusPosition:focusPosition maxWindowSize:((preferredMaxCount > 0) ? preferredMaxCount : preferredMaxWindowSize)];
    completion(didAdjust);
}

- (void)prependChatItems {
    for (NSInteger i=0; i<10; i++) {
        
        self.lastID += 1;
        
        ChatItemObject *chatItem = [ChatItemObject new];
        chatItem.type = @"simple";
        chatItem.uid = [[NSNumber numberWithInteger:self.lastID] stringValue];
        
        [super insertItem:chatItem position:InsertPositionTop];
    }
    
    [self.delegate chatDataSourceDidUpdate:self context:BMAChatUpdatePagination];
}

- (void)appendChatItem {
    
    self.lastID += 1;
    
    ChatItemObject *chatItem = [ChatItemObject new];
    chatItem.type = @"simple";
    chatItem.uid = [[NSNumber numberWithInteger:self.lastID] stringValue];

    [super insertItem:chatItem position:InsertPositionBottom];
    
    [self.delegate chatDataSourceDidUpdate:self context:BMAChatUpdateNormal];
}

- (void)clean {
    [super clean];
    [self.delegate chatDataSourceDidUpdate:self context:BMAChatUpdateReload];
}

@end
