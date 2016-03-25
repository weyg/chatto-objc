//
//  BMASerialQueue.m
//  MessagesCollectionView
//
//  Created by Aziz Latypov on 23/03/16.
//  Copyright © 2016 Aziz Latypov. All rights reserved.
//

#import "BMASerialQueue.h"

@interface BMASerialQueue ()
@property (nonatomic, assign) BOOL isBusy;
@property (nonatomic, assign) BOOL isStopped;
@property (nonatomic, strong) NSMutableArray <BMATaskClosure>* taskQueue;
@end

@implementation BMASerialQueue

- (instancetype)init
{
    self = [super init];
    if (self) {
        _taskQueue = [NSMutableArray new];
    }
    return self;
}

- (void)addTask:(BMATaskClosure)task {
    [self.taskQueue addObject:task];
    [self maybeExecuteNextTask];
}

- (void)start {
    self.isStopped = NO;
    [self maybeExecuteNextTask];
}

- (void)stop {
    self.isStopped = YES;
}

- (BOOL)isEmpty {
    return self.taskQueue.count == 0;
}

- (void)maybeExecuteNextTask {
    if (!self.isStopped && !self.isBusy) {
        if (!self.isEmpty) {
            BMATaskClosure firstTask = [self.taskQueue firstObject];
            [self.taskQueue removeObjectAtIndex:0];
            
            self.isBusy = YES;
            
            __weak typeof(self) weakSelf = self;
            firstTask(^{
                weakSelf.isBusy = NO;
                [weakSelf maybeExecuteNextTask];
            });
        }
    }
}

@end