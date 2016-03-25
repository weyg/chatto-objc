//
//  FakeDataSource.h
//  MessagesCollectionView
//
//  Created by Latipov Aziz on 24/03/16.
//  Copyright © 2016 Aziz Latypov. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "VIOSChatDataSourceProtocol.h"
#import "SlidingDataSource.h"

@interface FakeDataSource : SlidingDataSource <VIOSChatDataSourceProtocol>
@property (weak, nonatomic) id<VIOSChatDataSourceDelegateProtocol> delegate;
- (void)prependChatItems;
- (void)appendChatItem;
- (void)clean;
@end
