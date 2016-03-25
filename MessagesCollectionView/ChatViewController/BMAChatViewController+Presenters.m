//
//  BMAChatViewController+Presenters.m
//  MessagesCollectionView
//
//  Created by Aziz Latypov on 23/03/16.
//  Copyright © 2016 Aziz Latypov. All rights reserved.
//

#import "BMAChatViewController+Presenters.h"

@interface BMAChatItemCellPresenterObject : NSObject <ChatItemPresenterProtocol>
@end
@implementation BMAChatItemCellPresenterObject

+ (void)registerCels:(UICollectionView*)collectionView {
}

- (BOOL)canCalculateHeightInBackground { return YES; }
- (CGFloat)heightForCell:(CGFloat)maximumWidth decorationAttributes:(id<ChatItemDecorationAttributesProtocol>)decorationAttributes {
    return 50 + [decorationAttributes topMargin] + [decorationAttributes bottomMargin];
}

- (UICollectionViewCell*)dequeueCell:(UICollectionView*)collectionView indexPath:(NSIndexPath*)indexPath {
    return [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
}

- (void)configureCell:(UICollectionViewCell*)cell decorationAttributes:(id<ChatItemDecorationAttributesProtocol>)decorationAttributes {
    
}

@end

@implementation BMAChatViewController (Presenters)
//public func presenterForIndex(index: Int, decoratedChatItems: [DecoratedChatItem]) -> ChatItemPresenterProtocol {
//    guard index < decoratedChatItems.count else {
//        // This can happen from didEndDisplayingCell if we reloaded with less messages
//        return DummyChatItemPresenter()
//    }
//    
//    let chatItem = decoratedChatItems[index].chatItem
//    if let presenter = self.presentersByChatItem.objectForKey(chatItem) as? ChatItemPresenterProtocol {
//        return presenter
//    }
//    let presenter = self.createPresenterForChatItem(chatItem)
//    self.presentersByChatItem.setObject(presenter, forKey: chatItem)
//    return presenter
//}
//
//public func createPresenterForChatItem(chatItem: ChatItemProtocol) -> ChatItemPresenterProtocol {
//    for builder in self.presenterBuildersByType[chatItem.type] ?? [] {
//        if builder.canHandleChatItem(chatItem) {
//            return builder.createPresenterWithChatItem(chatItem)
//        }
//    }
//    return DummyChatItemPresenter()
//}
//
//public func decorationAttributesForIndexPath(indexPath: NSIndexPath) -> ChatItemDecorationAttributesProtocol? {
//    return self.decoratedChatItems[indexPath.item].decorationAttributes
//}

- (id<ChatItemPresenterProtocol>)presenterForIndexPath:(NSIndexPath*)indexPath {
    return [self presenterForIndex:indexPath.row decoratedChatItems:self.decoratedChatItems];
}

- (id<ChatItemPresenterProtocol>)presenterForIndex:(NSInteger)index
                                decoratedChatItems:(NSArray<id<BMADecoratedChatItem>>*)decoratedChatItems
{
    if (index < decoratedChatItems.count) {
        return [BMAChatItemCellPresenterObject new];
    }
    
    id item = self.decoratedChatItems[index];
    id presenter = [self.presentersByChatItem objectForKey:item];
    if (presenter) {
        return presenter;
    }
    
    presenter = [BMAChatItemCellPresenterObject new];
    [self.presentersByChatItem setObject:presenter forKey:item];
    
    return presenter;
}

- (id<ChatItemDecorationAttributesProtocol>)decorationAttributesForIndexPath:(NSIndexPath*)indexPath
{
    return [self.decoratedChatItems[indexPath.item] decorationAttributes];
}

#pragma mark - DataSource -

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.decoratedChatItems count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    return cell;
}


@end
