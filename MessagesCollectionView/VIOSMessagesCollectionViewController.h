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

@interface VIOSMessagesCollectionViewController : UICollectionViewController <VIOSChatViewInputProtocol>
@property (weak, nonatomic) id<VIOSChatViewOutputProtocol> presenter;
@end
