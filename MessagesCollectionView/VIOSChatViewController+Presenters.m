//
//  VIOSChatViewController+Presenters.m
//  MessagesCollectionView
//
//  Created by Aziz Latypov on 23/03/16.
//  Copyright © 2016 Aziz Latypov. All rights reserved.
//

#import "VIOSChatViewController+Presenters.h"

@implementation VIOSChatViewController (Presenters)
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

@end
