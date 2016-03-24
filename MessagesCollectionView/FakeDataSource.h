//
//  FakeDataSource.h
//  MessagesCollectionView
//
//  Created by Latipov Aziz on 24/03/16.
//  Copyright © 2016 Aziz Latypov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VIOSChatDataSourceProtocol.h"

@interface FakeDataSource : NSObject <VIOSChatDataSourceProtocol>
@property (weak, nonatomic) id<VIOSChatDataSourceDelegateProtocol> delegate;
- (void)addChatItemCount:(NSInteger)count;
- (void)addChatItem;
@end
