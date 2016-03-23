//
//  VIOSMessagesCollectionViewController.m
//  vipole
//
//  Created by Aziz Latypov on 17/03/16.
//  Copyright © 2016 vipole. All rights reserved.
//

#import "VIOSChatViewController.h"

#import "VIOSChatCollectionViewLayout.h"

@implementation VIOSChatViewController

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
    
    [(VIOSChatCollectionViewLayout*)self.collectionViewLayout setDelegate:self.collectionView];
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

//func performBatchUpdates(
//                         updateModelClosure updateModelClosure: () -> Void,
//                         changes: CollectionChanges,
//                         context: UpdateContext,
//                         completion: () -> Void) {
//    let shouldScrollToBottom = context != .Pagination && self.isScrolledAtBottom()
//    let oldRect = self.rectAtIndexPath(changes.movedIndexPaths.first?.indexPathOld)
//    let myCompletion = {
//        // Found that cells may not match correct index paths here yet! (see comment below)
//        // Waiting for next loop seems to fix the issue
//        dispatch_async(dispatch_get_main_queue(), { () -> Void in
//            completion()
//        })
//    }
//    
//    if context == .Normal {
//        
//        UIView.animateWithDuration(self.constants.updatesAnimationDuration, animations: { () -> Void in
//            // We want to update visible cells to support easy removal of bubble tail or any other updates that may be needed after a data update
//            // Collection view state is not constistent after performBatchUpdates. It can happen that we ask a cell for an index path and we still get the old one.
//            // Visible cells can be either updated in completion block (easier but with delay) or before, taking into account if some cell is gonna be moved
//            
//            updateModelClosure()
//            self.updateVisibleCells(changes)
//            
//            self.collectionView.performBatchUpdates({ () -> Void in
//                self.collectionView.deleteItemsAtIndexPaths(Array(changes.deletedIndexPaths))
//                self.collectionView.insertItemsAtIndexPaths(Array(changes.insertedIndexPaths))
//                for move in changes.movedIndexPaths {
//                    self.collectionView.moveItemAtIndexPath(move.indexPathOld, toIndexPath: move.indexPathNew)
//                }
//            }) { (finished) -> Void in
//                myCompletion()
//            }
//        })
//    } else {
//        updateModelClosure()
//        self.collectionView.reloadData()
//        self.collectionView.collectionViewLayout.prepareLayout()
//        myCompletion()
//    }
//    
//    if shouldScrollToBottom {
//        self.scrollToBottom(animated: context == .Normal)
//    } else {
//        let newRect = self.rectAtIndexPath(changes.movedIndexPaths.first?.indexPathNew)
//        self.scrollToPreservePosition(oldRefRect: oldRect, newRefRect: newRect)                         <-------- scroll to preserve current location !
//    }
//}

