//
//  VIOSMessagesCollectionViewController.m
//  vipole
//
//  Created by Aziz Latypov on 17/03/16.
//  Copyright © 2016 vipole. All rights reserved.
//

#import "VIOSMessagesCollectionViewController.h"

@implementation VIOSMessagesCollectionViewController

- (void)beginUpdates {
}

- (void)endUpdates {
}

- (void)updateSectionAtIndex:(NSInteger)sectionIndex changeType:(VIOSChatChangeType)type {
}

- (void)updateMessageAtIndexPath:(NSIndexPath *)oldIndexPath newIndexPath:(NSIndexPath *)newIndexPath changeType:(VIOSChatChangeType)type {
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
