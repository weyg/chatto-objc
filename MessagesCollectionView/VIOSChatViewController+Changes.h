//
//  VIOSChatViewController+Changes.h
//  MessagesCollectionView
//
//  Created by Aziz Latypov on 23/03/16.
//  Copyright © 2016 Aziz Latypov. All rights reserved.
//

#import "VIOSChatViewController.h"

#import "VIOSChatDataSourceProtocol.h"
#import "VIOSChatCollectionViewLayout.h"

@interface VIOSChatViewController (Changes) <VIOSChatDataSourceDelegateProtocol, VIOSChatCollectionViewLayoutDelegate>
- (double)focusPosition;
- (void)enqueueModelUpdate:(VIOSChatUpdateType)context;
@end
