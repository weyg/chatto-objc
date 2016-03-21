//
//  VIOSChatMessageCallType.h
//  vipole
//
//  Created by Aziz Latypov on 22/01/16.
//  Copyright © 2016 vipole. All rights reserved.
//

#ifndef VIOSChatMessageCallType_h
#define VIOSChatMessageCallType_h

typedef enum : NSUInteger {
    VIOSChatMessageCallUnknown,
    VIOSChatMessageCallIncomingActive,
    VIOSChatMessageCallActive,
    VIOSChatMessageCallFinished,
    VIOSChatMessageCallMissed,
    VIOSChatMessageCallError,
} VIOSChatMessageCallType;

#endif /* VIOSChatMessageCallType_h */
