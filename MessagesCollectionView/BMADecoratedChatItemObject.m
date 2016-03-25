//
//  BMADecoratedChatItemObject.m
//  MessagesCollectionView
//
//  Created by Aziz Latypov on 25/03/16.
//  Copyright © 2016 Aziz Latypov. All rights reserved.
//

#import "BMADecoratedChatItemObject.h"

@implementation BMADecoratedChatItemObject
- (instancetype)initWithChatItem:(id<BMAChatItemProtocol>)chatItem
                      attributes:(id<BMAChatItemDecorationAttributesProtocol>)attributes
{
    self = [super init];
    if (self) {
        _chatItem = chatItem;
        _decorationAttributes = attributes;
    }
    return self;
}
@end
