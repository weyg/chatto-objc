//
//  BMAFakeDataSource.h
//  MessagesCollectionView
//
//  Created by Latipov Aziz on 24/03/16.
//  Copyright © 2016 Aziz Latypov. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BMAChatDataSourceProtocol.h"
#import "BMASlidingDataSource.h"

@interface BMAFakeDataSource : BMASlidingDataSource <BMAChatDataSourceProtocol>
@property (weak, nonatomic) id<BMAChatDataSourceDelegateProtocol> delegate;
- (void)prependChatItems;
- (void)appendChatItem;
- (void)clean;
@end
