//
//  BMAMessagesCollectionViewController.h
//  vipole
//
//  Created by Aziz Latypov on 17/03/16.
//  Copyright © 2016 vipole. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BMAChatDataSourceProtocol.h"
#import "BMASerialQueue.h"

#import "BMAChatItemProtocol.h"
#import "BMADecoratedChatItemProtocol.h"

#import "BMAChatCollectionViewLayout.h"
#import "BMAChatCollectionViewLayoutModel.h"

#import "BMAChatItemPresenterProtocol.h"

@protocol ChatItemsDecoratorProtocol
-(NSArray<id<BMADecoratedChatItemProtocol>>*)decorateItems:(NSArray<id<BMAChatItemProtocol>>*)chatItems;
@end

@interface BMAChatViewController : UICollectionViewController

@property (nonatomic, strong) id<BMAChatDataSourceProtocol> chatDataSource;
@property (nonatomic, strong) id<BMASerialQueueProtocol> updateQueue;
@property (nonatomic, strong) NSArray<id<BMADecoratedChatItemProtocol>> *decoratedChatItems;
@property (nonatomic, strong) BMAChatCollectionViewLayoutModel *layoutModel;
@property (nonatomic, assign) BOOL isFirstLayout;
@property (nonatomic, assign) BOOL autoLoadingEnabled;

@property (nonatomic, strong) NSArray<id<BMAChatItemPresenterProtocol>> *presenters;
@property (nonatomic, strong) NSMapTable<id<BMAChatItemProtocol>,id<BMAChatItemPresenterProtocol>> *presentersByChatItem;
@property (nonatomic, strong) NSMapTable<UICollectionViewCell*,id<BMAChatItemPresenterProtocol>> *presentersByCell;

/**
 - You can use a decorator to:
 - Provide the ChatCollectionViewLayout with margins between messages
 - Provide to your pressenters additional attributes to help them configure their cells (for instance if a bubble should show a tail)
 - You can also add new items (for instance time markers or failed cells)
 */
@property (nonatomic, strong) id<ChatItemsDecoratorProtocol> chatItemsDecorator;

- (CGRect)rectAtIndexPath:(NSIndexPath*)indexPath;

@end
