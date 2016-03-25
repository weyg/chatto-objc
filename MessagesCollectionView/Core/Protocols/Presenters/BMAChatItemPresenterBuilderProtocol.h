//
//  BMAChatItemPresenterBuilderProtocol.h
//  MessagesCollectionView
//
//  Created by Aziz Latypov on 25/03/16.
//  Copyright © 2016 Aziz Latypov. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BMAChatItemProtocol.h"
#import "BMAChatItemPresenterProtocol.h"

@protocol BMAChatItemPresenterBuilderProtocol
- (BOOL)canHandleChatItem:(id<BMAChatItemProtocol>)chatItem;
- (id<BMAChatItemPresenterProtocol>)createPresenterWithChatItem:(id<BMAChatItemProtocol>)chatItem;
- (NSString*)presenterType;
@end
