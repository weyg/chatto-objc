//
//  VIOSChatUpdateContextType.h
//  MessagesCollectionView
//
//  Created by Aziz Latypov on 23/03/16.
//  Copyright © 2016 Aziz Latypov. All rights reserved.
//

typedef enum : NSUInteger {
    VIOSChatUpdateNormal,
    VIOSChatUpdateFirstLoad,
    VIOSChatUpdatePagination,
    VIOSChatUpdateReload,
    VIOSChatUpdateMessageCountReduction,
} VIOSChatUpdateType;