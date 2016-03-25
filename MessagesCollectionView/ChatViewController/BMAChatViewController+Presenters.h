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
#import "BMADecoratedChatItemProtocol.h"

#import "BMAChatItemPresenterProtocol.h"
#import "BMAChatItemDecorationAttributesProtocol.h"

@interface BMAChatViewController (Presenters)
- (id<BMAChatItemPresenterProtocol>)presenterForIndex:(NSInteger)index decoratedChatItems:(NSArray<id<BMADecoratedChatItemProtocol>>*)decoratedChatItems;
- (id<BMAChatItemPresenterProtocol>)presenterForIndexPath:(NSIndexPath*)indexPath;
- (id<BMAChatItemDecorationAttributesProtocol>)decorationAttributesForIndexPath:(NSIndexPath*)indexPath;
@end
