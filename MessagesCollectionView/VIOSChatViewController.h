//
//  VIOSMessagesCollectionViewController.h
//  vipole
//
//  Created by Aziz Latypov on 17/03/16.
//  Copyright © 2016 vipole. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "VIOSChatViewInputProtocol.h"
#import "VIOSChatViewOutputProtocol.h"

#import "VIOSChatDataSourceProtocol.h"
#import "VIOSSerialQueue.h"

#import "VIOSChatItemProtocol.h"
#import "VIOSChatCollectionViewLayoutModel.h"

@interface VIOSChatViewController : UICollectionViewController <VIOSChatViewInputProtocol>

@property (nonatomic, weak) id<VIOSChatViewOutputProtocol> presenter;

@property (nonatomic, strong) id<VIOSChatDataSourceProtocol> chatDataSource;
@property (nonatomic, strong) id<VIOSSerialQueueProtocol> updateQueue;
@property (nonatomic, strong) NSArray<VIOSDecoratedChatItem> *decoratedChatItems;
@property (nonatomic, strong) VIOSChatCollectionViewLayoutModel *layoutModel;
@property (nonatomic, assign) BOOL isFirstLayout;
@property (nonatomic, assign) BOOL autoLoadingEnabled;
@end
