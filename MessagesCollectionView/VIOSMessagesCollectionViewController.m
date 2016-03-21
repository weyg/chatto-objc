//
//  VIOSMessagesCollectionViewController.m
//  vipole
//
//  Created by Aziz Latypov on 17/03/16.
//  Copyright © 2016 vipole. All rights reserved.
//

#import "VIOSMessagesCollectionViewController.h"

#import "VIOSMessagesCollectionViewLayout.h"

@implementation VIOSMessagesCollectionViewController

- (void)beginUpdates {
}

- (void)endUpdates {
}

- (void)updateSectionAtIndex:(NSInteger)sectionIndex changeType:(VIOSChatChangeType)type {
}

- (void)updateMessageAtIndexPath:(NSIndexPath *)oldIndexPath newIndexPath:(NSIndexPath *)newIndexPath changeType:(VIOSChatChangeType)type {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [(VIOSMessagesCollectionViewLayout*)self.collectionViewLayout setDelegate:self.collectionView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSLog(@"did appear");
    
    self.collectionView.alwaysBounceVertical = YES;
    
    [self.collectionView reloadData];
    [self.collectionView setContentOffset:CGPointMake(0, self.collectionView.contentSize.height)];
    
    NSLog(@"did scroll");
}

#pragma mark - DataSource -

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 4;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    return cell;
}

@end
