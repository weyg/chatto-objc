//
//  VIOSChatMessageCallActionType.h
//  vipole
//
//  Created by Aziz Latypov on 22/01/16.
//  Copyright © 2016 vipole. All rights reserved.
//

#ifndef VIOSChatMessageCallActionType_h
#define VIOSChatMessageCallActionType_h

typedef enum : NSUInteger {
    VIOSChatMessageCallFinish  = 1,
    VIOSChatMessageCallAccept  = 2,
    VIOSChatMessageCallIgnore  = 3,
    VIOSChatMessageCallDecline = 4,
} VIOSChatMessageCallActionType;

#endif /* VIOSChatMessageCallActionType_h */
