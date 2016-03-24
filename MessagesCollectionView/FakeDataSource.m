//
//  FakeDataSource.m
//  MessagesCollectionView
//
//  Created by Latipov Aziz on 24/03/16.
//  Copyright © 2016 Aziz Latypov. All rights reserved.
//

#import "FakeDataSource.h"

@interface ChatItemObject : NSObject <VIOSChatItemProtocol>
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *type;
@end
@implementation ChatItemObject
@end

@interface FakeDataSource ()
@property (strong, nonatomic) NSArray <id<VIOSChatItemProtocol>> *chatItems;
@property (nonatomic, assign) NSInteger lastID;
@end

@implementation FakeDataSource

- (BOOL)hasMoreNext {return NO; }
- (BOOL)hasMorePrevious { return NO; }

//- (NSArray <id<VIOSChatItemProtocol>> *)chatItems {
//    ChatItemObject *chatItem = [ChatItemObject new];
//    chatItem.type = @"simple";
//    chatItem.uid = @"0";
//    return @[
//             chatItem
//             ];
//}

- (void)loadNext:(void(^)())completion {
    completion();
}

- (void)loadPrevious:(void(^)())completion {
    completion();
}

- (void)adjustNumberOfMessagesToPreferredMaxCount:(NSInteger)preferredMaxCount
                                    focusPosition:(double)focusPosition
                                       completion:(void(^)(BOOL didAdjust))completion
{
    completion(YES);
}

- (void)addChatItem { [self addChatItemCount:5]; }

- (void)addChatItemCount:(NSInteger)count {
    NSMutableArray *newItems = [NSMutableArray new];
    for (NSInteger i=0; i<count; i++) {
        
        self.lastID += 1;
        
        ChatItemObject *chatItem = [ChatItemObject new];
        chatItem.type = @"simple";
        chatItem.uid = [[NSNumber numberWithInteger:self.lastID] stringValue];
    
        [newItems addObject:chatItem];
    }
    
    self.chatItems = [newItems arrayByAddingObjectsFromArray:self.chatItems];
    
    [self.delegate chatDataSourceDidUpdate:self context:VIOSChatUpdatePagination];
}

@end
