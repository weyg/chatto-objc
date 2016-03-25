//
//  BMAMessagesCollectionViewController.m
//  vipole
//
//  Created by Aziz Latypov on 17/03/16.
//  Copyright © 2016 vipole. All rights reserved.
//

#import "BMAChatViewController.h"

#import "BMAChatCollectionViewLayout.h"

#import "BMASerialQueue.h"

#import "BMAChatViewController+Changes.h"

#import "BMAFakeDataSource.h"

@implementation BMAChatViewController

- (CGRect)rectAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath) {
        return [[self.collectionView layoutAttributesForItemAtIndexPath:indexPath] frame];
    }
    return CGRectZero;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.updateQueue = [BMASerialQueue new];
    
    self.decoratedChatItems = @[];
    self.layoutModel = [BMAChatCollectionViewLayoutModel createModelForCollectionViewWidth:0 itemsLayoutData:@[]];
    
    self.presenters = [NSMutableArray new];
    self.presentersByChatItem =
    [[NSMapTable alloc] initWithKeyOptions:NSPointerFunctionsWeakMemory valueOptions:NSPointerFunctionsStrongMemory capacity:0];
    self.presentersByCell =
    [[NSMapTable alloc] initWithKeyOptions:NSPointerFunctionsWeakMemory valueOptions:NSPointerFunctionsWeakMemory capacity:0];
    
    self.collectionView.alwaysBounceVertical = YES;
    [(BMAChatCollectionViewLayout*)self.collectionView.collectionViewLayout setDelegate:self];
    
    BMAFakeDataSource *dataSource = [BMAFakeDataSource new];
    self.chatDataSource = dataSource;
    
    [NSTimer scheduledTimerWithTimeInterval:1.5 target:dataSource selector:@selector(prependChatItems) userInfo:nil repeats:YES];
    [NSTimer scheduledTimerWithTimeInterval:0.5 target:dataSource selector:@selector(appendChatItem) userInfo:nil repeats:YES];
    [NSTimer scheduledTimerWithTimeInterval:3.5 target:dataSource selector:@selector(clean) userInfo:nil repeats:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"view did appear");
    [self.collectionView reloadData];
//    [self.collectionView setContentOffset:CGPointMake(0, self.collectionView.contentSize.height)];
}

- (void)setChatDataSource:(id<BMAChatDataSourceProtocol>)chatDataSource {
    _chatDataSource = chatDataSource;
    
    _chatDataSource.delegate = self;
    [self enqueueModelUpdate:BMAChatUpdateReload];
}

@end