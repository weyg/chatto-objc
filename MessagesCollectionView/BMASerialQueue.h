//
//  BMASerialQueue.h
//  MessagesCollectionView
//
//  Created by Aziz Latypov on 23/03/16.
//  Copyright © 2016 Aziz Latypov. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^BMATaskClosureComletion)();
typedef void(^BMATaskClosure)(BMATaskClosureComletion completion);

@protocol BMASerialQueueProtocol
- (void)addTask:(BMATaskClosure)task;
- (void)start;
- (void)stop;
- (BOOL)isEmpty;
@end

@interface BMASerialQueue : NSObject <BMASerialQueueProtocol>

@end
