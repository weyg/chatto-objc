//
//  BMAChatViewController+Presenters.h
//  MessagesCollectionView
//
//  Created by Aziz Latypov on 23/03/16.
//  Copyright © 2016 Aziz Latypov. All rights reserved.
//

#import "BMAChatViewController.h"

#import "BMAChatUpdateType.h"
#import "BMAChatItemProtocol.h"

@interface BMAChatViewController (Presenters)
- (id<ChatItemPresenterProtocol>)presenterForIndex:(NSInteger)index decoratedChatItems:(NSArray<id<BMADecoratedChatItem>>*)decoratedChatItems;
- (id<ChatItemPresenterProtocol>)presenterForIndexPath:(NSIndexPath*)indexPath;
- (id<ChatItemDecorationAttributesProtocol>)decorationAttributesForIndexPath:(NSIndexPath*)indexPath;
@end
