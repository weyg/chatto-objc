//
//  VIOSChatViewController+Presenters.h
//  MessagesCollectionView
//
//  Created by Aziz Latypov on 23/03/16.
//  Copyright © 2016 Aziz Latypov. All rights reserved.
//

#import "VIOSChatViewController.h"

#import "VIOSChatUpdateType.h"
#import "VIOSChatItemProtocol.h"

@interface VIOSChatViewController (Presenters)
- (id<ChatItemPresenterProtocol>)presenterForIndex:(NSInteger)index decoratedChatItems:(NSArray<id<VIOSDecoratedChatItem>>*)decoratedChatItems;
- (id<ChatItemPresenterProtocol>)presenterForIndexPath:(NSIndexPath*)indexPath;
- (id<ChatItemDecorationAttributesProtocol>)decorationAttributesForIndexPath:(NSIndexPath*)indexPath;
@end
