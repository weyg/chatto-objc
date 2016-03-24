//
//  VIOSMessagesCollectionViewController.h
//  vipole
//
//  Created by Aziz Latypov on 17/03/16.
//  Copyright © 2016 vipole. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "VIOSChatViewInputProtocol.h"
#import "VIOSChatViewOutputProtocol.h"

#import "VIOSChatDataSourceProtocol.h"
#import "VIOSSerialQueue.h"

#import "VIOSChatItemProtocol.h"

#import "VIOSChatCollectionViewLayout.h"
#import "VIOSChatCollectionViewLayoutModel.h"

@protocol ChatItemsDecoratorProtocol
-(NSArray<id<VIOSDecoratedChatItem>>*)decorateItems:(NSArray<id<VIOSChatItemProtocol>>*)chatItems;
@end

@interface VIOSChatViewController : UICollectionViewController <VIOSChatViewInputProtocol>

@property (nonatomic, weak) id<VIOSChatViewOutputProtocol> presenter;

@property (nonatomic, strong) id<VIOSChatDataSourceProtocol> chatDataSource;
@property (nonatomic, strong) id<VIOSSerialQueueProtocol> updateQueue;
@property (nonatomic, strong) NSArray<id<VIOSDecoratedChatItem>> *decoratedChatItems;
@property (nonatomic, strong) VIOSChatCollectionViewLayoutModel *layoutModel;
@property (nonatomic, assign) BOOL isFirstLayout;
@property (nonatomic, assign) BOOL autoLoadingEnabled;

@property (nonatomic, strong) NSArray<id<ChatItemPresenterProtocol>> *presenters;
@property (nonatomic, strong) NSMapTable<id<VIOSChatItemProtocol>,id<ChatItemPresenterProtocol>> *presentersByChatItem;
@property (nonatomic, strong) NSMapTable<UICollectionViewCell*,id<ChatItemPresenterProtocol>> *presentersByCell;

/**
 - You can use a decorator to:
 - Provide the ChatCollectionViewLayout with margins between messages
 - Provide to your pressenters additional attributes to help them configure their cells (for instance if a bubble should show a tail)
 - You can also add new items (for instance time markers or failed cells)
 */
@property (nonatomic, strong) id<ChatItemsDecoratorProtocol> chatItemsDecorator;

- (CGRect)rectAtIndexPath:(NSIndexPath*)indexPath;

@end
