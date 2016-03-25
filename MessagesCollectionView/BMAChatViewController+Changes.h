//
//  BMAChatViewController+Changes.h
//  MessagesCollectionView
//
//  Created by Aziz Latypov on 23/03/16.
//  Copyright © 2016 Aziz Latypov. All rights reserved.
//

#import "BMAChatViewController.h"

#import "BMAChatDataSourceProtocol.h"
#import "BMAChatCollectionViewLayout.h"

@interface BMAChatViewController (Changes) <BMAChatDataSourceDelegateProtocol, BMAChatCollectionViewLayoutDelegate>
- (double)focusPosition;
- (void)enqueueModelUpdate:(BMAChatUpdateType)context;
@end
