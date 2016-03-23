//
//  VIOSSerialQueue.h
//  MessagesCollectionView
//
//  Created by Aziz Latypov on 23/03/16.
//  Copyright © 2016 Aziz Latypov. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^VIOSTaskClosureComletion)();
typedef void(^VIOSTaskClosure)(VIOSTaskClosureComletion completion);

@protocol VIOSSerialQueueProtocol
- (void)addTask:(VIOSTaskClosure)task;
- (void)start;
- (void)stop;
- (BOOL)isEmpty;
@end

@interface VIOSSerialQueue : NSObject <VIOSSerialQueueProtocol>

@end
