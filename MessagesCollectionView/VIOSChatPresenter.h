//
//  VIOSChatPresenter.h
//  MessagesCollectionView
//
//  Created by Aziz Latypov on 17/03/16.
//  Copyright © 2016 Aziz Latypov. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "VIOSChatViewInputProtocol.h"
#import "VIOSChatViewOutputProtocol.h"

@interface VIOSChatPresenter : NSObject <VIOSChatViewOutputProtocol>
@property (weak, nonatomic) id<VIOSChatViewInputProtocol> view;
@end
