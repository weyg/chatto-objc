//
//  BMADecoratedChatItemProtocol.h
//  MessagesCollectionView
//
//  Created by Aziz Latypov on 25/03/16.
//  Copyright © 2016 Aziz Latypov. All rights reserved.
//

#import "BMAChatItemProtocol.h"
#import "BMAChatItemDecorationAttributesProtocol.h"

@protocol BMADecoratedChatItemProtocol
@property (nonatomic, readonly) id<BMAChatItemProtocol> chatItem;
@property (nonatomic, readonly) id<BMAChatItemDecorationAttributesProtocol> decorationAttributes;
@end

