//
//  VIOSChatChangeTypes.h
//  TestVIPER
//
//  Created by Aziz Latypov on 14/11/15.
//  Copyright © 2015 Aziz Latypov. All rights reserved.
//

#ifndef VIOSChatChangeTypesh
#define VIOSChatChangeTypesh

typedef enum : NSUInteger {
    VIOSChatChangeTypeInsert,
    VIOSChatChangeTypeDelete,
    VIOSChatChangeTypeUpdate,
    VIOSChatChangeTypeMove
} VIOSChatChangeType;

#endif /* VIOSChatChangeTypesh */
