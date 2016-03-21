//
//  VIOSChatMessageAuthType.h
//  vipole
//
//  Created by Aziz Latypov on 22/01/16.
//  Copyright © 2016 vipole. All rights reserved.
//

#ifndef VIOSChatMessageAuthType_h
#define VIOSChatMessageAuthType_h

typedef enum : NSUInteger {
    VIOSChatCellAuthRequest = 1,
    VIOSChatCellAuthDeny,
    VIOSChatCellAuthIgnore,
    VIOSChatCellAuthAccept,
} VIOSChatMessageAuthType;

#endif /* VIOSChatMessageAuthType_h */
