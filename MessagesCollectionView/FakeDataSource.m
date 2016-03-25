//
//  FakeDataSource.m
//  MessagesCollectionView
//
//  Created by Latipov Aziz on 24/03/16.
//  Copyright © 2016 Aziz Latypov. All rights reserved.
//

#import "FakeDataSource.h"

static NSInteger preferredMaxWindowSize = 500;
static NSInteger preferredPageSize = 50;

@interface ChatItemObject : NSObject <VIOSChatItemProtocol>
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *type;
@end
@implementation ChatItemObject
@end

@interface FakeDataSource ()
@property (nonatomic, assign) NSInteger lastID;
@end

@implementation FakeDataSource

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

- (NSArray<id<VIOSChatItemProtocol>> *)chatItems {
    return self.itemsInWindow;
}

- (BOOL)hasMoreNext {
    return [super hasMore];
}

- (BOOL)hasMorePrevios {
    return [super hasPrevious];
}

- (void)loadNext:(void(^)())completion {
    [super loadNext];
    [super adjustWindowWithFocusPosition:1 maxWindowSize:preferredMaxWindowSize];
    completion();
}

- (void)loadPrevious:(void(^)())completion {
    [super loadPrevios];
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
        
        @synchronized (self) {
            self.lastID += 1;
        }
        
        ChatItemObject *chatItem = [ChatItemObject new];
        chatItem.type = @"simple";
        chatItem.uid = [[NSNumber numberWithInteger:self.lastID] stringValue];
        
        [super insertItem:chatItem position:InsertPositionTop];
    }
    
    [self.delegate chatDataSourceDidUpdate:self context:VIOSChatUpdatePagination];
}

- (void)appendChatItem {
    @synchronized (self) {
        self.lastID += 1;
    }
    
    ChatItemObject *chatItem = [ChatItemObject new];
    chatItem.type = @"simple";
    chatItem.uid = [[NSNumber numberWithInteger:self.lastID] stringValue];

    [super insertItem:chatItem position:InsertPositionBottom];
    
    [self.delegate chatDataSourceDidUpdate:self context:VIOSChatUpdateNormal];
}

- (void)clean {
    [super clean];
    [self.delegate chatDataSourceDidUpdate:self context:VIOSChatUpdateReload];
}

@end
