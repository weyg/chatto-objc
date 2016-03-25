//
//  VIOSChatDataSourceProtocol.h
//  MessagesCollectionView
//
//  Created by Aziz Latypov on 23/03/16.
//  Copyright © 2016 Aziz Latypov. All rights reserved.
//

//public protocol ChatDataSourceDelegateProtocol: class {
//    func chatDataSourceDidUpdate(chatDataSource: ChatDataSourceProtocol)
//    func chatDataSourceDidUpdate(chatDataSource: ChatDataSourceProtocol, context: ChatViewController.UpdateContext)
//}
//
//public protocol ChatDataSourceProtocol: class {
//    var hasMoreNext: Bool { get }
//    var hasMorePrevious: Bool { get }
//    var chatItems: [ChatItemProtocol] { get }
//    weak var delegate: ChatDataSourceDelegateProtocol? { get set }
//    
//    func loadNext(completion: () -> Void)
//    func loadPrevious(completion: () -> Void)
//    func adjustNumberOfMessages(preferredMaxCount preferredMaxCount: Int?, focusPosition: Double, completion:(didAdjust: Bool) -> Void) // If you want, implement message count contention for performance, otherwise just call completion(false)
//}
//

#import <Foundation/Foundation.h>

#import "VIOSChatUpdateType.h"
#import "VIOSChatItemProtocol.h"

@protocol VIOSChatDataSourceProtocol;

@protocol VIOSChatDataSourceDelegateProtocol
- (void)chatDataSourceDidUpdate:(id<VIOSChatDataSourceProtocol>)chatDataSource context:(VIOSChatUpdateType)context;
@end

@protocol VIOSChatDataSourceProtocol

- (BOOL)hasMoreNext;
- (BOOL)hasMorePrevios;
@property (nonatomic, readonly) NSArray <id<VIOSChatItemProtocol>> *chatItems;
@property (nonatomic, weak) id<VIOSChatDataSourceDelegateProtocol> delegate;

- (void)loadNext:(void(^)())completion;
- (void)loadPrevious:(void(^)())completion;
- (void)adjustNumberOfMessagesToPreferredMaxCount:(NSInteger)preferredMaxCount focusPosition:(double)focusPosition completion:(void(^)(BOOL didAdjust))completion;

@end