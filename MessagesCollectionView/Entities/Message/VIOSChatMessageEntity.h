//
//  VIOSChatMessageEntityProtocol.h
//  vipole
//
//  Created by Aziz Latypov on 09/11/15.
//  Copyright © 2015 vipole. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "VIOSChatMessageDirectionType.h"
#import "VIOSChatMessageAskAnswerType.h"
#import "VIOSChatMessageCallType.h"
#import "VIOSChatMessageAuthType.h"

@interface VIOSChatMessageEntity : NSObject
@property (strong, nonatomic) NSString *senderIdentifier;
@property (strong, nonatomic) NSString *guid;
@property (strong, nonatomic) NSDate *createdAt;
@property (nonatomic) VIOSChatMessageDirectionType direction;
@property (nonatomic) BOOL isDeleted;
@property (nonatomic) BOOL isDelivered;
@property (strong, nonatomic) NSString *previewString;
@property (strong, nonatomic) NSString *contentHtml;
@property (strong, nonatomic) NSString *type;
@end