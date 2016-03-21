//
//  VIOSChatCellCallActionType.h
//  vipole
//
//  Created by Aziz Latypov on 22/01/16.
//  Copyright © 2016 vipole. All rights reserved.
//

#ifndef VIOSChatCellCallActionType_h
#define VIOSChatCellCallActionType_h

#import "VIOSChatMessageCallActionType.h"

typedef enum : NSUInteger {
    VIOSChatCellCallActionAccept = VIOSChatMessageCallAccept,
    VIOSChatCellCallActionDeny   = VIOSChatMessageCallDecline,
    VIOSChatCellCallActionIgnore = VIOSChatMessageCallIgnore,
    VIOSChatCellCallActionFinish = VIOSChatMessageCallFinish,
} VIOSChatCellCallActionType;

#endif /* VIOSChatCellCallActionType_h */
