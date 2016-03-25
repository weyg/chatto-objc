//
//  BMADecoratedChatItemObject.h
//  MessagesCollectionView
//
//  Created by Aziz Latypov on 25/03/16.
//  Copyright © 2016 Aziz Latypov. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BMADecoratedChatItemProtocol.h"
#import "BMADecoratedChatItemProtocol.h"
#import "BMAChatItemDecorationAttributesProtocol.h"

@interface BMADecoratedChatItemObject : NSObject <BMADecoratedChatItemProtocol>
@property (nonatomic, strong) id<BMAChatItemProtocol> chatItem;
@property (nonatomic, strong) id<BMAChatItemDecorationAttributesProtocol> decorationAttributes;
- (instancetype)initWithChatItem:(id<BMAChatItemProtocol>)chatItem
                      attributes:(id<BMAChatItemDecorationAttributesProtocol>)attributes;
@end
