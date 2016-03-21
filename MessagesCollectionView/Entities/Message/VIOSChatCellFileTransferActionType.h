//
//  VIOSChatCellFileTransferActionType.h
//  vipole
//
//  Created by Aziz Latypov on 22/01/16.
//  Copyright © 2016 vipole. All rights reserved.
//

#ifndef VIOSChatCellFileTransferActionType_h
#define VIOSChatCellFileTransferActionType_h

typedef enum : NSUInteger {
    VIOSChatCellFileTransferDownloadStart,
    VIOSChatCellFileTransferDownloadCancel,
    VIOSChatCellFileTransferDownloadPause,
    VIOSChatCellFileTransferDownloadResume,
    VIOSChatCellFileTransferShowFileActions,
    VIOSChatCellFileTransferOpenFile,
} VIOSChatCellFileTransferActionType;

#endif /* VIOSChatCellFileTransferActionType_h */
