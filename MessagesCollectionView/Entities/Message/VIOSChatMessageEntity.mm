//
//  VIOSHistoryRecord+ChatMessageEntityProtocol.m
//  vipole
//
//  Created by Aziz Latypov on 10/11/15.
//  Copyright © 2015 vipole. All rights reserved.
//

#import "VIOSChatMessageEntity.h"

@interface VIOSChatMessageEntity ()
@end

@implementation VIOSChatMessageEntity

- (NSString *)description
{
    return [NSString stringWithFormat:@"Sender: %@\nDate: %@\nPreview: %@", self.senderIdentifier, self.createdAt, self.previewString];
}

@end